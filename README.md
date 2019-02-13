# traefiked-stacks
Ready-to-use Traefik reverse proxied stacks for Docker in swarm mode.

![example use](https://raw.githubusercontent.com/gogson/traefiked-stacks/master/.img/cli.png)

## Stacks

All stacks contains Traefik labels for auto reverse proxying.
__Reverse proxying is optional and will only work if you start the traefiked stack. You can start all stacks independently__.

- `traefiked` self reverse-proxied [Traefik](https://github.com/containous/traefik) stack listening to port 80/443
- `whoami` simple reverse-proxied [whoami](https://github.com/jwilder/whoami) for testing purpose
- `swarmpit` reverse-proxied [Swarmpit](https://github.com/swarmpit/swarmpit) stack
- `swirl` reverse-proxied [Swirl](https://github.com/cuigh/swirl) stack

To start a stack

```
./deploy stack-folder-name
```

## Configuration

Each stack contains it's own `.env` file for you to configure.
You can define custom hostnames for backends and various stack configuration.

## Reverse proxy

For the reverse proxy to work, you __need__ to deploy the traefiked stack.
The proxy runs on port 80/443 and auto generate SSL certificates.

First, edit the reverse proxy configuration in the `traefiked/.env` file.

Then, deploy

```
./deploy traefiked
```

## Proxying a service

You must put your service in the overlay `traefiked` network (it will be created by the `deploy.sh` script).
You must attach the service to the network, and declare the network as external: look at `whoami/docker-stack.yml` for an example.
Finaly, set the Traefik labels needed with the proxied app port.

## Contribute

You're welcome to submit PR for adding new stacks.

## TODO

- Better CLI
- Check if swarm mode is ON
- Set root domain configuration during first CLI use
- On stack deploy: choose hostname / subdomain (avoid editing .env file for it)