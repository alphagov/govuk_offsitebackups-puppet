#GOV.UK Off-site Backup Networking

The tools within this directory allow you to configure firewall, load-balancing
and NAT rules on GOV.UK off-site backup vSE firewalls. Under the hood, the tools
in this folder make use of `vcloud-edge_gateway` to communicate with the vCloud
API.

Each provider directory contains a number of files which can be used in the
creation of networks on vCloud using `vcloud-edge_gateway`. There are two ways
to use this Gem.

## Building automatically

Firstly, check to see if there is a Jenkins build job - this is the most
pain-free way to configure your networking rules. Before running the job, amend
`edge.yaml` to reflect the rules you require.

## Building manually

If there is no Jenkins build job, you will need to run the commands yourself.
From the root of the provider directory, you run `vcloud-configure-edge` and
specify a file containing your Edge Gateway rules. Interface files are available
in each provider directory, but if you have added a new interface, you may need
to use [`vcloud-walk`](https://github.com/alphagov/vcloud-walker) to add the UUID
of the interface to the interfaces file to make it ready for use.

A full example of the command is as follows:

`bundle exec vcloud-configure-edge [PATH]`

Further `vcloud-edge_gateway` documentation is available at
https://github.com/alphagov/vcloud-edge_gateway.
