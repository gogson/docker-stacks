# traefiked-stacks
Ready-to-use Traefik reverse proxied stacks for Docker in swarm mode

![example use](https://raw.githubusercontent.com/gogson/traefiked-stacks/master/.img/cli.png)

## Configuration

Each stack contains it's own `.env` file for you to configure.
You can define custom hostnames for backends and various stack configuration.

## Reverse proxy

For the reverse proxy to work, you __need__ to deploy the web-proxy stack.
The proxy runs on port 80/443 and auto generate SSL certificates.

First, edit the reverse proxy configuration in the `web-proxy/.env` file.

Then, deploy

```
./deploy web-proxy
```

## Stacks

All stacks contains Traefik labels for auto reverse proxying.
__Reverse proxying is optional and will only work if you start the web-proxy stack. You can start all stacks independently__.

- `web-proxy` self reverse-proxied Traefik stack listening to port 80/443
- `whoami` simple reverse-proxied whoami for testing purpose
- `swarmpit` reverse-proxied Swarmpit stack

To start a stack

```
./deploy stack-folder-name
```

## Proxying a service

You must put your service in the overlay `traefiked` network (it will be created by the `deploy.sh` script).
You must attach the service to the network, and declare the network as external: look at `whoami/docker-stack.yml` for an example

## Contribute

You're welcome to submit PR for adding new stacks.