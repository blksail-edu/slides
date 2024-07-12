---
theme: apple-basic
highlighter: shiki
lineNumbers: true
info: |
  ## Introduction to Robot Operating System 2 (ROS2) Jazzy!

  See course at [AUVC 2024 by BLKSAIL](https://blksail-edu.github.io)
drawings:
  persist: false
transition: slide-left
title: Introduction to ROS2
download: true




layout: intro-image-right
image: 'https://raw.githubusercontent.com/ros-infrastructure/artwork/master/distributions/jazzy/JazzyJalisco-noborder.png'
---

<div>
    <h1>Introduction to ROS2</h1>
    <span class="font-700">Robot Operating System 2</span>
</div>

<div class="absolute bottom-15">
    Marina Nelson
</div>

---

<h1>What is ROS2 ?</h1>

<ul>
    <li>ROS2 (Robot Operating System 2) is a set of open-source libraries and tools used to build robotics applications.</li>
    <li>ROS2 is a middleware for robotics:
    <ul>
        <li>ROS2 acts as a layer between the operating system and user-defined code like Python3 executables.</li>
    </ul></li>
</ul>

---
layout: two-cols
---

<h1>ROS</h1>

<ul>
    <li>Initial release in 2010.</li>
    <li>Intended for single robot systems.</li>
    <li>Strong community support and large ecosystem <br/>of open-source libraries.</li>
    <li>ROS Noetic (the final ROS distribution) has its <br/> End of Life (EOL) in May 2025.</li>
</ul>

::right::

<h1>ROS2</h1>

<ul>
    <li>Initial release in 2016 with first Long Term Support (LTS) release in 2020.</li>
    <li>Designed for multi-robot systems.</li>
    <li>Integrated with DDS (Data Distribution Service) middleware for improved real-time communication, scalability, and reliability.</li>
</ul>

---

<h1>ROS2 Jazzy Jalisco</h1>

<ul>
    <li>ROS2 "Jazzy" Jalisco is the newest distribution of ROS2 (released May 2024).</li>
    <li>Jazzy is an LTS release with support until May of 2029.</li>
    <li>Jazzy is compatible with Ubuntu 24.04</li>
    <li>We will use ROS2 Jazzy to perform computer vision and image processing, control the BlueROV2's motors, camera, and lights, and execute the "mission."</li>
</ul>


---

<h1>Understanding the ROS2 Graph</h1>

<ul>
    <li>Nodes</li>
    <li>Topics</li>
    <li>Messages</li>
    <li>Parameters</li>
    <li>Services</li>
    <li>Actions</li>
</ul>

---

<h1>Nodes</h1>

<ul>
    <li>Nodes are executables that simplify complex software into single-purpose modular units; e.g.,
    <ul>
        <li>BlueROV2 camera driver</li>
        <li>BlueROV2 motor driver</li>
    </ul></li>    
    <li>Nodes are written in Python3 or C++ using:
    <ul>
        <li><strong>rclpy:</strong> ROS2 Client Library for Python3</li>
        <li><strong>rclcpp:</strong> ROS2 Client Library for C++</li>
    </ul></li>
    <li>Nodes communicate using topics, services, actions, and parameters.</li>
</ul>

---
layout: image
image: 'https://docs.ros.org/en/jazzy/_images/Nodes-TopicandService.gif'
---

---

<h1>Topics</h1>

<ul>
    <li>Topics are named communication channels with specific message types; e.g.,
    <ul>
        <li>Our BlueROV2 camera driver node publishes <strong>Image</strong> messages to the topic named <strong>"/blue/image"</strong>.</li>
    </ul></li>
</ul>

---

<h1>Messages</h1>

<ul>
    <li>Messages define the structure and types of data being communicated on topics.</li>
    <li>The structure of a message is broken down by field type and field name:
    <ul>
        <li>Field names describe what the data represents.</li>
        <li>Field types describe the data types of each field name's data.</li>
    </ul></li>
    <li>Field types are either primitive data types, arrays of a primitive data type, or ROS2 message types:
    <ul>
        <li>bool, byte, char, float32, float64, int8, int16, uint16, int32, uint32, int64, uint64, string, wstring</li>
    </ul></li>
</ul>

```c {all|1-2|4|5-9|10|all}
# sensor_msgs/msg/Image message
# file: sensor_msgs/msg/Image.msg

std_msgs/Header header
uint32 height
uint32 width
string encoding
uint8 is_bigendian
uint32 step
uint8[] data
```

---

<h1>Parameters</h1>

<ul>
    <li>Parameters are configuration values of a node; e.g.,
    <ul>
        <li>An IP address</li>
        <li>The maximum operating depth</li>
        <li>The control mode (manual, depth hold, etc.)</li>
    </ul></li>
    <li>Parameters can be node-specific or constant for all nodes in the ROS2 environment.</li>
</ul>

---

<h1>Services</h1>

<ul>
    <li>Services are another form of inter-node communication.</li>
    <li>When a service is called, node one will send a request to node two. Node two will then perform some function, then send a response to node one.
    <ul>
        <li>Our BlueROV2 motor driver node can arm/disarm the ROV.</li>
    </ul></li>
    <li>Services are broken down by field names and field types, but unlike messages, they are separated into requests and responses.</li>
</ul>

```c {all|1-2|4|6-7|all}
# mavros_msgs/srv/CommandBool service
# file: mavros_msgs/srv/CommandBool.srv

bool value
---
bool success
uint8 result
```

---

<h1>Actions</h1>

<ul>
    <li>Actions are a new communication type in ROS2 intended for long running tasks.</li>
    <li>Actions consist of three parts: a goal, regular feedback (status updates), and a result.</li>
    <li>Action goals, feedback, and results are broken down similar to .msg and .srv files:</li>
</ul>

```c {all|3|5|7|all}
# Define an action for autonomous navigation

geometry_msgs/PoseStamped target_pose
---
float32 percent_complete
---
bool success
```

---

<h1>Services & Actions (cont.)</h1>

<ul>
    <li>Although the components of services and actions are defined in .srv and .action files, they are executed using server and client nodes:
    <ul>
        <li>Service Server and Service Client</li>
        <li>Action Server and Action Client</li>
    </ul></li>
</ul>

---
layout: image
image: 'https://docs.ros.org/en/jazzy/_images/Service-MultipleServiceClient.gif'
---

---
layout: image
image: 'https://docs.ros.org/en/jazzy/_images/Action-SingleActionClient.gif'
---
