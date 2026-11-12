# ahformatter-container

## Build

Place `AHFormatterV75-7.5E-MR7.x86_64.rpm` and `AHFormatter.lic` in the same directory as the Dockerfile. The image installs the rpm as described in the [Antenna House Formatter V7.5 Install Manual for Linux](https://www.antenna.co.jp/AHF/InstallManual/V75/html/Linux.html).

```shellsession
$ docker build --tag ahformatterv75-7.5e-mr7.x86_64:latest .
```

### ARM (aarch64)

The Graviton2 build of the rpm runs on linux/arm64 hosts such as Apple silicon Macs. Place `AHFormatterV75_Graviton2-7.5E-MR7.aarch64.rpm` next to the Dockerfile and pass its name as `AHF_RPM`.

```shellsession
$ docker build --build-arg AHF_RPM=AHFormatterV75_Graviton2-7.5E-MR7.aarch64.rpm --tag ahformatterv75-7.5e-mr7.aarch64:latest .
```

## Run

```shellsession
$ docker run --rm --user "$(id -u):$(id -g)" --volume .:/data ahformatterv75-7.5e-mr7.x86_64:latest -d input.fo -o output.pdf
```

## Using system fonts

Modify a copy of the bundled `/usr/AHFormatterV75/etc/font-config.xml`, mount it over the original, and mount the directories configured in it.

```shellsession
$ docker run --rm --entrypoint cat ahformatterv75-7.5e-mr7.x86_64:latest /usr/AHFormatterV75/etc/font-config.xml > font-config.xml
```

Add `<font-folder path="/usr/share/fonts" recursive="true"/>` to `font-config.xml`.

```shellsession
$ docker run --rm --user "$(id -u):$(id -g)" --volume ./font-config.xml:/usr/AHFormatterV75/etc/font-config.xml:ro --volume /usr/share/fonts:/usr/share/fonts:ro --volume .:/data ahformatterv75-7.5e-mr7.x86_64:latest -d input.fo -o output.pdf
```
