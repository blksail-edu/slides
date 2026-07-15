---
theme: apple-basic
highlighter: shiki
lineNumbers: true
info: |
  ## Introduction to Robot Operating System 2 (ROS 2 Jazzy)

  See course at [AUVC 2026 by BLKSAIL](https://blksail-edu.github.io)
drawings:
  persist: false
transition: slide-left
title: Introduction to ROS 2 Jazzy
download: true
layout: intro-image-right
image: 'https://github.com/blksail-edu/slides/blob/main/slides/resources/ROS2_JazzyJalisco.png'
---

# Introduction to ROS 2 Jazzy

Robot Operating System 2 — Long Term Support Release

---

# Overview

- **ROS 2 Jazzy Jalisco** (May 2024 – May 2029 LTS) — latest Long Term Support release
  - Open-source framework: libraries, tools, and conventions for robotics software
  - Modular, distributed architecture — no single master (unlike ROS 1)
  - DDS-based middleware (default: Fast DDS / Cyclone DDS) for real-time, reliable communication
  - Used across research, education, and production robotics (autonomy, manipulation, marine, aerospace)

---

![ROS 2 Architecture](https://github.com/blksail-edu/slides/blob/main/slides/resources/ROS2_Architecture.png)

---

# ROS 2 Terminology

---

# Nodes

- Nodes are **independent processes** that perform specific computational tasks.
- Nodes communicate via:
  - **Topics** (publish/subscribe — streaming data)
  - **Services** (request/response — synchronous RPC)
  - **Actions** (goal/feedback/result — long-running tasks with progress)
- Nodes are written in Python 3 or C++ using ROS 2 client libraries:
  - **rclpy** — Python client library
  - **rclcpp** — C++ client library
- **Examples:**
  - Depth Controller
  - BlueROV2 Camera Interface

---

---
layout: image
image: "https://github.com/blksail-edu/slides/blob/main/slides/resources/ROS2_Nodes.gif"
---

---

# Topics & Messages

- Topics are named communication buses for streaming data between nodes:
  - **Publishers** — send messages to a topic
  - **Subscribers** — receive messages from a topic
  - Many-to-many, anonymous, decoupled communication
- **Messages** are strongly-typed data structures (defined in `.msg` files):
  - Primitive types, arrays, nested messages, constants
  - Generated code provides type-safe publish/subscribe APIs
- **Example:** BlueROV2 camera publishes `sensor_msgs/msg/Image` on `/bluerov2/camera`

---

---
layout: image
image: "https://github.com/blksail-edu/slides/blob/main/slides/resources/ROS2_Topic_Nx_Publisher_Nx_Subscriber.gif"
---

---

# Services

- Services provide synchronous request/response communication:
  - **Client** — sends a request, blocks until response
  - **Server** — handles requests, returns responses
- Service types (`.srv` files) define separate request and response structures
- **Example:** Arm/disarm BlueROV2 via `/bluerov2/arming` (uses `std_srvs/srv/SetBool`)

---

---
layout: image
image: "https://github.com/blksail-edu/slides/blob/main/slides/resources/ROS2_Service.gif"
---

---

# Actions

- Actions handle **long-running tasks with feedback** (navigation, manipulation, missions):
  - **Goal** — client sends desired outcome
  - **Feedback** — server streams progress (distance remaining, % complete)
  - **Result** — final outcome on completion/cancellation
- Non-blocking client API; supports preemption/cancellation mid-execution
- **Example:** `nav2_msgs/action/NavigateToPose` — move BlueROV2 to waypoint, stream distance/error feedback

---

# Parameters

- Parameters are typed configuration values for nodes (set at launch or runtime):
  - Declared in node code with defaults; overridden via YAML, CLI, or launch files
  - Support dynamic reconfiguration — change values without restarting nodes (Jazzy+)
- **Examples:**
  - BlueROV2 connection: IP address, port, vehicle ID
  - Controller tuning: PID gains, control loop rate, thrust limits

---

# Workspace & Packages

- Workspace = directory for developing & building ROS 2 packages:
  - `colcon build` compiles packages; `source install/setup.bash` overlays workspace
- Standard layout:
  - **src/** — your packages (clone or create here)
  - build/ — intermediate build artifacts
  - install/ — compiled libraries, executables, resources
  - log/ — build logs
- Packages organize related functionality (nodes, msgs, srvs, actions, launch, configs)

---

# Next Steps

- **Try it now:** `ros2 run demo_nodes_cpp talker` + `ros2 run demo_nodes_py listener`
- **Tutorials:** [docs.ros.org/en/jazzy](https://docs.ros.org/en/jazzy/Tutorials.html) — Beginner CLI, Writing Nodes, Launch Files
- **BlueROV2 specifics:** [blksail-edu.github.io](https://blksail-edu.github.io) — vehicle interfaces, missions, simulation
- **Key tools:** `ros2 topic`, `ros2 service`, `ros2 action`, `ros2 param`, `ros2 node`, `rqt_graph`, `foxglove`
