## Bitwarden setup for Developer environment

This documentation aims to guide developers on setting up Bitwarden locally as
a vault in their development environment.

By using Docker, we can launch a local Bitwarden instance and automatically
connect to it whenever we enter the folder of this repository. Additionally, we
will automatically load secrets into the environment.

This approach allows developers to share secrets and use them locally on a
day-to-day basis.

### Why it matters

1. Increased productivity: When a development environment launches quickly, developers can start working more promptly. This avoids frustrating waiting times and allows developers to focus on the task at hand without interruptions. Increased productivity means projects can be delivered more swiftly.
1. Reduced errors: Automated development environments ensure that all the required configurations for the project are set up consistently. This prevents human errors associated with manually configuring the environment. Incorrect configuration can lead to bugs or compatibility issues that slow down development. An automated environment reduces these risks by providing a consistent working environment for all developers.
1. Collaboration ease: When all members of a development team use the same automated development environment, collaboration becomes easier. Each developer has access to the same tools and configurations, facilitating code sharing, issue resolution, and communication. Automated development environments foster a consistent approach to development and enable more efficient collaboration.
1. Flexibility and scalability: Automated development environments can be easily replicated and expanded as project needs evolve. If new developers join the team or if additional resources are required, the automated environment can be quickly provisioned. This allows for flexibility in scaling the development environment to accommodate changing project requirements.



## Requirements

- [`rtx`](https://github.com/jdxcode/rtx)
- [`docker`](https://www.docker.com/)

To integrate `rtx` and `direnv` with your shell login, you need to add hooks:

- [`rtx hooks`](https://github.com/jdxcode/rtx#quickstart)
- [`direnv hooks`](https://direnv.net/docs/hook.html)

Follow the steps below to add the hooks:

If you use **bash**, execute:
```sh
$ echo 'eval "$(~/bin/rtx activate bash)"' >> ~/.bashrc
$ echo -e "\neval "\$(direnv hook bash)"" >> ~/.bashrc
```
If you use **zsh**, execute:
```sh
$ echo 'eval "$(~/bin/rtx activate zsh)"' >> ~/.zshrc
$ echo -e "\neval "\$(direnv hook zsh)"" >> ~/.zshrc
```
Then, to apply the configuration, restart your terminal or simply execute this command:

**Bash**
```sh
$ source ~/.bashrc
```

**Zsh**
```sh
$ source ~/.zshrc
```

To set up the required tools, you need to install them locally. When you are in
the folder of the repository, use the following command:

```sh
$ rtx install
```

## Getting Started

For this example, Bitwarden will be launched locally. To launch it, run the
following command:

```sh
$ ./scripts/setup.sh
[+] Building 0.0s (0/0)
[+] Running 1/0
 ✔ Container bitwarden-vaultwarden-1  Running
Waiting for vaultwarden:80  .  up!
Everything is up
Saved setting `config`.


Bitwarden is automatically setup, default login are:

email: admin@example.com
password: master_password
```

Next, we will configure the .envrc file to load automatically each time we enter
this repository, in order to load secrets. You will be prompted to enter your
email and password:

```sh
$ direnv allow
direnv: loading ~/bitwarden/.envrc
direnv: using rtx
? Email address: admin@example.com
? Master password: [input is hidden] direnv: ([/usr/bin/direnv export zsh]) is taking a while to execute. Use CTRL-C to give up.
? Master password: [hidden]
direnv: export +BW_SESSION +TEST_PASSWORD +TEST_USERNAME
```

You can now verify that environment variables are loaded:

```sh
$ echo "${TEST_USERNAME} ${TEST_PASSWORD}"
test password
```
## Uninstall

To remove the bitwarden instance use:

```sh
$ docker-compose down
[+] Running 2/2
 ✔ Container bitwarden-vaultwarden-1  Removed
 ✔ Network bitwarden_default          Removed
```

