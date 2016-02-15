# Instructions

To test that the round-robin load balancer is working correctly, simply browse [here](http://www.devopper.co.uk/). You'll note that if you continually refresh, the IP address shown will change periodically which demonstrates the round-robin load balancer is working as intended.

## Further Reading

The intention of this project is to demonstrate how to automate full stack deployments using the following tools :-

| Tool | Description |
| ---- | ----------- |
| Packer | Used to automate the creation of machine images, in our case AMI's |
| Jenkins | We use this to build and deploy our example Go application |
| Puppet | In this case, used in a masterless configuration to setup and configure Nginx |
| Terraform | Define and build your infrastructure along with security groups etc (AWS) |



