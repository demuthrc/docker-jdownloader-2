# Docker container for JDownloader 2

This is a Docker container for Megabasterd
The GUI of the application is accessed through a modern web browser (no installation or configuration needed on the client side) or via any VNC client.



## Quick Start

**NOTE**: The Docker command provided in this quick start is given as an example
and parameters should be adjusted to your need.

Launch the JDownloader 2 docker container with the following command:
```
docker run -d \
    --name=megabasterd \
    -p 5800:5800 \
    -v /docker/megabasterd-2:/config:rw \
    -v mnt/omv/downloads:/output:rw \
    demuthrc/docker-megabasterd
```

Where:
  - `/docker/megabasterd`: This is where the application stores its configuration, log and any files needing persistency.
  - `mnt/omv/downloads`: This is where downloaded files are stored.

Browse to `http://your-host-ip:5800` to access the GUI.

## Documentation

Full documentation is available at https://github.com/demuthrc/docker-megabasterd.

