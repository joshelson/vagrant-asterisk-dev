# Asterisk Development Environment

[Vagrant] [vagrant]-based development environment for  [Asterisk] [asterisk]. Includes my preferred set of development tools and installs the Asterisk Test Suite.

It also will prompt for gerrit information to connect you to gerrit.asterisk.org for easier committing of repository changes.

Works fine on Linux, Mac and Windows hosts.

## Installation

### Dependencies

To use this development environment, you need to have [Vagrant] [vagrant-install] and [VirtualBox] [virtualbox-install] installed.

You also may want to install vbguest to prevent the VirtualBox Guest Additions from getting out of sync:

    $ vagrant plugin install vagrant-vbguest

### Starting Vagrant

First, clone the repo:

    $ git clone https://github.com/joshelson/vagrant-asterisk-dev.git
    $ cd vagrant-asterisk-dev

Ensure your SSH key is loaded. Command will be similar to:

    $ ssh-add ~/.ssh/id_rsa
    $ ssh-agent

Now you can build the VM:

    $ vagrant up --provision

And SSH into it:

    $ vagrant ssh

### Starting developing


## Copyright and License

Licensed under the [Apache License, Version 2.0] [license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[asterisk]: http://asterisk.org
[vagrant]: http://vagrantup.com
[vagrant-install]: http://docs.vagrantup.com/v2/installation/index.html
[virtualbox]: https://www.virtualbox.org
[virtualbox-install]: https://www.virtualbox.org/wiki/Downloads

[license]: http://www.apache.org/licenses/LICENSE-2.0

