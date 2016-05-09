# Thanks to mschaefer https://faq.i3wm.org/question/1773/how-can-i-configure-i3wm-to-make-alttab-action-just-like-in-windows/%3C/p%3E.html
# Added little tweak to go switch only into a single workspace
import json
import subprocess


"""
Execute the given command and return the 
output as a list of lines
"""
def command_output(cmd):
    output = []
    if (cmd):
        p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, \
                                 stderr=subprocess.STDOUT)
        for line in p.stdout.readlines():
            output.append(line.rstrip())
    return output


def output_to_dict(output_list):
    output_string = ""
    for line in output_list:
        output_string += line
    return json.loads(output_string)


def find_windows(tree_dict, window_list):

    if (tree_dict.has_key("nodes") and len(tree_dict["nodes"]) > 0):
        # Time to check if we have a focused window in there
        # Added this to alt-tab only through windows in current workspace
        focused_workspace = False
        nodes_are_leaf = True
        for node in tree_dict["nodes"]:
            if (node["focused"] == True):
                focused_workspace = True
                break
            if node.has_key("nodes") and len(node["nodes"]) > 0:
                nodes_are_leaf = False
        # I don't want to change workspace with alt-tab
        # So, If current node is the parent of leaf that are in another workspace, don't add them
        if not focused_workspace and nodes_are_leaf:
            return window_list 
        for node in tree_dict["nodes"]:
            find_windows(node, window_list)
    else:
        if (tree_dict["layout"] != "dockarea" and not tree_dict["name"].startswith("i3bar for output") and not tree_dict["window"] == None):
            if tree_dict == []:
                return window_list
            window_list.append(tree_dict)

    return window_list        


def main():
    output = command_output("i3-msg -t get_tree")
    tree = output_to_dict(output)
    window_list = find_windows(tree, [])

    if len(window_list) == 0:
        return

    next_index = -1
    for i in range(len(window_list)):
        if (window_list[i]["focused"] == True):
            next_index = i+1
            break

#    next_index = len(window_list)
#    for i in range(len(window_list)-1, -1, -1):
#        if (window_list[i]["focused"] == True):
#            next_index = i-1
#            break

    next_id = 0;
    if next_index == -1 or next_index == len(window_list):
        next_id = window_list[0]["window"]
    else:        
        next_id = window_list[next_index]["window"]

    print next_id

main()

