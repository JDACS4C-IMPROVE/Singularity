# Singularity
Singularity definitions that can be extended to support execution of community models. These definition files range from base operating systems (ie Ubuntu 20.04) to fully configured containers.




### Best Practices for Build Recipes
see: (https://sylabs.io/guides/3.7/user-guide/definition_files.html)

When crafting your recipe, it is best to consider the following:

- Always install packages, programs, data, and files into operating system locations (e.g. not /home, /tmp , or any other directories that might get commonly binded on).
- Document your container. If your runscript doesn’t supply help, write a %help or %apphelp section. A good container tells the user how to interact with it.
- If you require any special environment variables to be defined, add them to the %environment and %appenv sections of the build recipe.
- Files should always be owned by a system account (UID less than 500).
- Ensure that sensitive files like /etc/passwd, /etc/group, and /etc/shadow do not contain secrets.
- Build production containers from a definition file instead of a sandbox that has been manually changed. This ensures greatest possibility of reproducibility and mitigates the “black box” effect.
