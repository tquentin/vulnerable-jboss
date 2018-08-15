# JBoss

Materials to build JBoss 4.0.0/5.1.0/6.0.0-Final in container mode for security testing

## Usage

### Online Mode

In online mode, the archive of specified JBoss version will be downloaded from SourceForge. Use the following command to build the image and specify version of JBoss you want to build on `version=N`:

Supported JBoss versions: 4, 5 and 6

```
$ docker build -t . isecure/jboss --build-arg version=6
```

To create a new container from the image:

```
$ docker run -d -p 8080:8080 --name jboss -e JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64 isecure/jboss
```

The application server can be accessed via `YOUR_HOST_MACHINE:8080`

### Offline Mode

In offline mode, the archive of specified JBoss version **MUST** be downloaded and stored in directory `server`. Please rename downloaded archive(s) with the following condition:

- `4.zip` for `jboss-4.x.x.zip`
- `5.zip` for `jboxx-5.x.x.zip`
- `6.zip` for `jboss-6.x.x.zip`

After that, you have to modify `Dockerfile` to comment `Online build` section and uncomment `Offline build` section. So, the new Dockerfile should be:

```Docker
# Offline build
ARG version
ADD build/ /build
ADD server/${version}.zip /server/${version}.zip
RUN /build/build_offline.sh $version

# Online build
# ARG version
# ADD build/ /build
# RUN /build/build_online.sh $version
```

Then,

```
$ docker build -t . isecure/jboss --build-arg version=5
$ docker run -d -p 8080:8080 --name jboss -e JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64 isecure/jboss
```