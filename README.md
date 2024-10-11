# EasyDAV

EasyDAV is a lightweight file upload and query server based on Nginx. It allows you to upload files via WebDAV and explore the directory structure in JSON format, using an easy-to-deploy Docker setup.

## Features

- **File Uploads via WebDAV**: Securely upload files to a specified directory.
- **Directory Listing in JSON**: View files and directories in a simple JSON format.
- **File Downloads**: Easily download files via HTTP.
- **Authentication**: Secure access with HTTP Basic Authentication.
- **Flexible Deployment**: Easily configurable using environment variables.

## Quick Start

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Setup and Configuration

1. Run the service using Docker directly:

   ```bash
   docker run -d -p 8080:80 xieyanbo/easydav
   ```

   Alternatively, create a `docker-compose.yml` file using the sample provided below:

   ```yaml
   version: "3.8"

   services:
     nginx-webdav:
       image: xieyanbo/easydav
       container_name: easydav
       environment:
         - PUID=1000
         - PGID=1000
         - TZ=Etc/UTC
         - WEBDAV_USER=user
         - WEBDAV_PASSWORD=pwd
       volumes:
         - ./data:/data
       ports:
         - 8080:80
       restart: unless-stopped
   ```

   Then, launch the service with:

   ```bash
   docker-compose up -d
   ```

2. Access the WebDAV file upload interface:

   - **URL**: `http://localhost:8080/upload/`
   - **Username and Password**: The credentials you set in the environment variables (`WEBDAV_USER`, `WEBDAV_PASSWORD`).

3. View directory structure in JSON format:

   - **URL**: `http://localhost:8080/files/`
   - The output will display the files and directories in JSON format.

4. Download files:

   - **URL**: http://localhost:8080/files/filename
   - Replace `filename` with the actual name of the file you want to download.

## Environment Variables

You can customize the service by setting the following environment variables:

- `WEBDAV_USER`: Username for WebDAV authentication.
- `WEBDAV_PASSWORD`: Password for WebDAV authentication.
- `PUID`: Optional. User ID for file ownership.
- `PGID`: Optional. Group ID for file ownership.
- `TZ`: Timezone setting (default: `Etc/UTC`).

## Example Commands and Responses

### Upload File via WebDAV

You can use any WebDAV client (like `curl`, `Cyberduck`, etc.) to upload files:

```bash
curl -u user:pwd -T example.txt http://localhost:8080/upload/
# or specify the path
curl -u user:pwd -T example.txt http://localhost:8080/upload/subdir/new.txt
```

### View Files and Directories in JSON

Access the `/files/` URL to get a JSON response listing the contents of the directory:

```bash
curl -u user:pwd http://localhost:8080/files/
# or query by the dir name
curl -u user:pwd http://localhost:8080/files/subdir/
```

Sample JSON response:

```json
{
    "format": "json",
    "autoindex": [
        {
            "name": "example.txt",
            "type": "file",
            "mtime": "Fri, 04 Oct 2024 06:49:55 GMT",
            "size": 1234
        },
        {
            "name": "subdir",
            "type": "directory",
            "mtime": "Fri, 04 Oct 2024 06:48:00 GMT"
        }
    ]
}
```

### Download Files

You can directly download files that have been uploaded using a WebDAV client, or by visiting the `/files/` URL followed by the file name.

For example, to download `example.txt`:

```bash
curl -u user:pwd -O http://localhost:8080/files/example.txt
```

This will download the file example.txt to your local machine.

## Customizing the Configuration

If you need to adjust the Nginx configuration or paths, you can modify the `nginx.conf` file located in the `./config/nginx` directory.

## License

This project is open-source and available under the [MIT License](LICENSE).
