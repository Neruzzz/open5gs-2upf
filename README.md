# Open5GS 2UPF Cloud-Edge Deployment

This repository provides a complete deployment setup for a 5G standalone core using Open5GS (version **2.6.6**) and Amarisoft gNB. It supports a dual deployment architecture with two pairs of SMF/UPF components: one in the **cloud** and one at the **edge**. The UE dynamically selects the user plane route based on the **APN** configuration: one APN points to the cloud UPF, and another points to the edge UPF, enabling differentiated traffic handling and slicing.

⚠️ The version of Open5GS is **pinned to 2.6.6** in the Dockerfile to ensure compatibility. Using a different version may result in errors due to changes in configuration formats or APIs in newer releases.

This project builds upon the original work by Herle Supreeth:  
🔗 [https://github.com/herlesupreeth/docker_open5gs](https://github.com/herlesupreeth/docker_open5gs)

---

## 📁 Repository Structure

Each folder corresponds to a network function or support module:

- `amf/` – **Access and Mobility Management Function**: Handles UE registration, connection management, and mobility.
- `smf/` – **Session Management Function**: Manages sessions, APN selection, and interaction with UPFs.
- `upf/` – **User Plane Function**: Routes and forwards user traffic toward the internet or data network.
- `ausf/` – **Authentication Server Function**: Authenticates UEs using information from UDM and security keys.
- `pcf/` – **Policy Control Function**: Applies network policies to sessions (QoS, traffic rules).
- `udm/` – **Unified Data Management**: Stores subscriber profiles (e.g., subscription, authentication credentials).
- `udr/` – **Unified Data Repository**: Backend storage for UDM and PCF data.
- `nrf/` – **Network Repository Function**: Allows service discovery between network functions.
- `nssf/` – **Network Slice Selection Function**: Assigns slices based on UE subscription or request.
- `bsf/` – **Binding Support Function**: Manages binding of IP addresses to subscribers for IP session continuity.
- `scp/` – **Service Communication Proxy**: Manages HTTP/2 message routing between control plane functions.
- `webui/` – **Web-based User Interface**: Allows operator to manage subscribers, devices, and sessions visually.

Additional components:

- `metrics/`: Prometheus exporter for monitoring Open5GS services.
- `mqtt/`: MQTT config file for the broker.
- `scripts/`: Shell scripts for image building, service orchestration, and automation.
- `SIM/`: Contains SIM profiles and parameters used in the lab (IMSI, K, OPc, etc.) and commands to program a SIM for slicing support.
- `UERANSIM/`: Simulation tool to emulate UE and gNB behavior for local testing.
- `.env`: Docker environment configuration.
- `deployment.yaml`: Main Docker Compose file used to launch the architecture.

---

## ⚙️ Initial Steps for Cloud and Edge Nodes

This project can run either in the **cloud only** or in a **cloud + edge** architecture.  
The following steps are **common to both setups** and must be applied to each node (cloud and/or edge).

### 1. Clone the repository

Clone this repository and navigate into it:

```bash
git clone <this_repo_url>
cd open5gs-2upf
```

### 2. Set your machine IP in the `.env` file

Edit the `.env` file and add the IP address of the machine that will run the deployment:

```bash
nano .env
```

Inside the file, make sure you have:

```env
DOCKER_HOST_IP=192.168.X.X
```

Replace `192.168.X.X` with the actual IP of the host.

### 3. Build the Open5GS Docker image

Use the build script provided to create the Open5GS Docker image:

```bash
cd scripts
./build.sh
```

This compiles Open5GS version **2.6.6** and prepares the Docker image for deployment.

### 4. Edge side `.env` modifications




### 5. Continue with Amarisoft Configuration

After setting up the environment and building the image,   you can proceed to configure **Amarisoft gNB** to connect to the cloud AMF.


---

## 📡 Amarisoft gNB Configuration

> ⚠️ **Note**: If SDRs are not detected after a reboot or crash, you must reinitialize them manually:
>
> ```bash
> cd trx_sdr/kernel/
> sudo ./init.sh
> ```

To connect Amarisoft gNB to the cloud AMF:

1. On the Amarisoft machine, go to:

```bash
cd enb/config
```

2. Copy or create a new config file from a standalone profile:

```bash
cp gnb-sa-* gnb-sa-open5gs
```

3. Edit the file `gnb-sa-open5gs` and set the IP and port of the AMF and the gNB machine IP:

```c
  amf_list: [
    {
      /* address of AMF for NGAP connection. Must be modified if the AMF runs on a different host */
      amf_addr: "192.168.x.x:38412",
    },
  ],
  /* GTP bind address (=address of the ethernet interface connected to the AMF). Must be modified if the AMF runs on a different host. */
  gtp_addr: "192.168.x.x"
```

Set also the 

4. Create or update the symlink `enb.cfg`:

```bash
ln -sf gnb-sa-open5gs enb.cfg
```

5. Restart the Amarisoft service:

```bash
sudo systemctl restart lte.service
```

To debug Amarisoft and access the interactive menu:

```bash
screen -r
```
---

## Deploy the docker composes

---

## Suscribe UE and check logs

---

## Two slices deployment

Modificar AMF, SMFs, NSSF
Config en el WebUI
Deployar

--- 

## 💡 Notes


## 📜 License

This project includes and extends code licensed under the Open5GS license and the MIT license of [docker_open5gs](https://github.com/herlesupreeth/docker_open5gs).

Additionally, this repository is released under a BSD-style license with an attribution clause. See the [`LICENSE`](./LICENSE) file for full terms.