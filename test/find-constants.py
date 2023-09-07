import re
import os
import argparse


def search_file(file_name=None) :
    
    if os.path.isfile(file_name) :
        pass

    fh = open(file_name, 'r')
    for line in fh:
        # variables = re.findall(r'([\w]+\s*)=\s*\w+', line)
        # numbers = values = re.findall(r'=(\s*[\d]+)', line)
        # strings = re.findall(r'=(\s*["\']{1}[\w]+["\']{1})', line)
        match = re.findall(r'([\w]+)\s*=\s*["\']([\w]+)["\']', line)
        
        # values = numbers + strings

        if (match):
            print( "\t".join([file_name, match[0][0] , match[0][1] , line.rstrip()]) )
            # print( file_name ,  variables, values)


def get_config():
    a=1
    b = 2
    c = b
    c ="string"

    parser = argparse.ArgumentParser()
    parser.add_argument("--verbosity", help="increase output verbosity")
    parser.add_argument("--file" , "-f" , help="search in file")
    parser.add_argument("--directory" , "-d" , help="search for python files in dir and check for constants")
    args = parser.parse_args()
    
    return args



def main(cfg):

    file_list = []
    if cfg.file and os.path.isfile(cfg.file) :
        file_list.append(cfg.file)
    
    for fn in file_list :
        print(fn)
        search_file(file_name=fn)

    


if __name__ == "__main__":
    cfg=get_config()
    main(cfg)