### awscli.sh

Shell scripts for managing Amazon Cloud's aws instances and services, useful for SysOps/DevOps who prefers to use shell scripting.

### Required:
```
You have AWS-CLI installed (http://aws.amazon.com/cli/)
Configuring aws credentials (http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)
```
### Scripts are splitted in several folders with several different json parser tools

```
Scripts in folder "awscli" need aws cli package only (pip install awscli)
Scripts in folder "jq" need jq installed - http://stedolan.github.io/jq/
Scripts in folder "JSON.sh" need JSON.sh installed - git clone https://github.com/dominictarr/JSON.sh.git
Scripts in folder "jsawk" need jsawk script installed - curl -L http://github.com/micha/jsawk/raw/master/jsawk > jsawk && chmod 755 jsawk
```

Scripts are tested under bash.

First working script:

awscli.sh / awscli / oaws  # will add more commands in it.
