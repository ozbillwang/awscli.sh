## Warning

There are some Cloudformation templates I wrote or collected, using some of them will automatically create many ec2 instances, large database instances, etc, it will generate big bill, so you need take care of the price before upload it to your system.

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
Scripts in folder "common" - BASH only. 
```

Scripts are tested under bash.
