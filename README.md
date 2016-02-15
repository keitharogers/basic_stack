# Instructions

To test that the round-robin load balancer is working correctly, simply browse [here](http://www.devopper.co.uk/). You'll note that if you continually refresh, the IP address shown will change periodically which demonstrates the round-robin load balancer is working as intended.

## Further Reading

The intention of this project is to demonstrate how to automate full stack deployments using the following tools :-

| Tool | Description |
| ---- | ----------- |
| Packer | Used to automate the creation of machine images, in our case AMI's |
| Jenkins | I use this to build and deploy our example Go application |
| Puppet | In this case, used in a masterless configuration to setup and configure Nginx |
| Terraform | I use this to automatically build and deploy our infrastructure in AWS |

## More Details

For further technical details relating to this project, please see each of the readme's at the following locations:

- [Packer](https://github.com/devopper/basic_stack/tree/master/packer-config)
- [Jenkins](https://github.com/devopper/basic_stack/tree/master/jenkins)
- [Puppet](https://github.com/devopper/basic_stack/tree/master/puppet)
- [Terraform](https://github.com/devopper/basic_stack/tree/master/terraform-config)
- [Application](https://github.com/devopper/basic_stack/tree/master/application)

