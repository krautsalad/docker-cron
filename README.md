# docker-cron

Cron in a Docker Container.

**docker-cron** is an Alpine-based Docker container running [Cron](https://wiki.alpinelinux.org/wiki/Cron). It allows you to define a custom crontab that is executed by the Cron daemon.

## Configuration

### Docker Compose Example

```yml
# docker-compose.yml
services:
  cron:
    container_name: cron
    environment:
      CRONTAB: |
        0 0 * * * echo "Already Midnight again!" >> /var/log/cron/cron.log 2>&1
        0 8 * * * echo "Good Morning!" >> /var/log/cron/cron.log 2>&1
      TZ: Europe/Berlin
    image: krautsalad/cron
    restart: unless-stopped
```

### Environment Variables

- `CRONTAB`: A complete crontab definition (default: empty).
- `TZ`: Timezone setting (default: UTC).

## How it works

The container runs Cron as a daemon, executing the cron jobs defined in your `CRONTAB` environment variable. To ensure that the output of your cron jobs is visible in the container logs, append `>> /var/log/cron/cron.log 2>&1` to your job commands. This log file is symlinked to the container's standard output.

## Source Code

You can find the full source code on [GitHub](https://github.com/krautsalad/docker-cron).
