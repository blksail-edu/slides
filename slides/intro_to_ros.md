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

---

<h1>Coding in the ROS2 Framework</h1>

<ul>
    <li>Nodes are compiled executables written in Python3 and C++.</li>
    <li>Nodes are located in ROS2 packages.</li>
    <li>Packages must be located in the src directory of a ROS2 workspace.</li>
</ul>

<h1>ROS2 Environment</h1>

<ul>
    <li>In ROS2, packages are either located at the installation path or in user-defined workspaces.</li>
    <li>To use ROS2 commands and default packages, the <strong>installation</strong> must be <strong>sourced</strong>.</li>
    <li>To run user-defined nodes, the user-defined ROS2 <strong>workspaces</strong> must also be <strong>sourced</strong>.</li> 
</ul>

---

<h1>Creating a ROS2 Workspace</h1>

<ul>
    <li>A ROS2 workspace is a directory at a path, preferably at the home directory ~/.</li>
    <li>When initializing the workspace, the ws directory must contain an empty src/ directory ~/your_ws/src/.</li>
    <li>All packages must go in the src/ directory within the workspace to be compiled correctly.</li>
    <li>For this course, we'll be creating and using a workspace named auvc_ws.</li>
</ul>

```zsh
cd && mkdir auvc_ws && cd auvc_ws && mkdir src
colcon build 
```

<ul>
    <li>Colcon is the compiler used by ROS2.</li>
    <li>Packages must be compiled in the workspace directory; e.g., ~/auvc_ws</li>
</ul>

```css {all|1|2|3|4|5|all}
auvc_ws/
├── build/
├── install/
├── log/
└── src/
```

---

<h1>Creating a ROS2 Workspace (cont.)</h1>

<ul>
    <li>Packages must be located within the <strong>src/</strong> directory of a ROS2 workspace.</li>
    <li>Packages can be located in subdirectories of the src/ directory.</li>
    <li>Each student should create a GitHub repository that contains all ROS2 packages for individual coursework.</li>
</ul>

```css {all|1|2|3-4|all}
src/
├── auvc_coursework/
│   ├── intro_to_ros/
│   ├── some_other_pkg/
```

---

<h1>Creating ROS2 Packages</h1>

<ul>
    <li>ROS2 packages should be created using a terminal command.</li>
</ul>

```zsh {1|2}
cd ~/auvc_ws/src/auvc_coursework
ros2 pkg create --build-type ament_python your_package_name
```

<ul>
    <li><strong>ament_python</strong> is the build type for ROS2 packages with only Python3 nodes.</li>
    <li><strong>ament_cmake</strong> is the build type for ROS2 packages with either only C++ nodes or a mix of Python3 and C++ nodes.</li>
</ul>

---

<h1>Default Structure of a ROS2 Package</h1>

<ul>
    <li>Creating a package with the command line will automatically populate several critical files.</li>
    <li><strong>package.xml</strong> and <strong>setup.py</strong> must be modified to to successfully build the package.</li>
    <li>Nodes (executable .py files) must go in <strong>your_pkg_name/your_pkg_name/</strong>, which in this case is <strong>intro_to_ros/intro_to_ros/</strong>.</li> 
</ul>

```css {all|1|2-3|5-6|all}
intro_to_ros/
├── package.xml
├── setup.py
├── setup.cfg
├── intro_to_ros/
│   └── __init__.py
├── resource/
└── test/
```

---

<h1>Example Node</h1>

<ul>
    <li>To create a new node in a package, create a .py executable.</li>
</ul>


```css {1,5-7}
intro_to_ros/
├── package.xml
├── setup.py
├── setup.cfg
├── intro_to_ros/
│   ├── __init__.py
│   └── pubsub.py
├── resource/
└── test/
```

---

<h1>Example Node (cont.)</h1>

```py {all|1-5|7|7,8,9|7,8,10|7,8,11|13-14|16-25|17|18|19|20-21|all}
#!/usr/bin/env python3

import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class PresentationExampleNode(Node):
    def __init__(self):
        super().__init__('presentation_example')
        self.string2_pub = self.create_publisher(String, '/example/string2', 10)
        self.string1_sub = self.create_subscriber(String, '/example/string1', self.string1_callback, 10)
    
    def string1_callback(self, msg):
        self.string2_pub.publish(msg)

def main(args=None):
    rclpy.init(args=args)
    node = PresentationExampleNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__=='__main__':
    main()
```

---

<h1>Updating package.xml</h1>

<ul>
    <li>Dependencies from all nodes must be added to <strong>package.xml</strong>.</li>
</ul>

```xml
<?xml version="1.0"?>
<?xml-model href="http://download.ros.org/schema/package_format3.xs>
<package format="3">
  <name>intro_to_ros</name>
  <version>0.0.0</version>
  <description>TODO: Package description</description>
  <maintainer email="blue@backseat.local">blue</maintainer>
  <license>TODO: License declaration</license>

  <test_depend>ament_copyright</test_depend>
  <test_depend>ament_flake8</test_depend>
  <test_depend>ament_pep257</test_depend>
  <test_depend>python3-pytest</test_depend>

  <export>
    <build_type>ament_python</build_type>
  </export>
</package>
```

---

<h1>Updating package.xml (cont.)</h1>

```xml {all|10-14}
<?xml version="1.0"?>
<?xml-model href="http://download.ros.org/schema/package_format3.xs>
<package format="3">
  <name>intro_to_ros</name>
  <version>0.0.0</version>
  <description>TODO: Package description</description>
  <maintainer email="blue@backseat.local">blue</maintainer>
  <license>TODO: License declaration</license>

  <build_depend>rclpy</build_depend>
  <build_depend>std_msgs</build_depend>

  <exec_depend>rclpy</exec_depend>
  <exec_depend>std_msgs</exec_depend>

  <test_depend>ament_copyright</test_depend>
  <test_depend>ament_flake8</test_depend>
  <test_depend>ament_pep257</test_depend>
  <test_depend>python3-pytest</test_depend>

  <export>
    <build_type>ament_python</build_type>
  </export>
</package>
```

---

<h1>Updating setup.py</h1>

<ul>
    <li>An entry point for each executable must be added to <strong>setup.py</strong>.</li>
</ul>

```py
from setuptools import find_packages, setup

package_name = 'intro_to_ros'
setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages', ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='mjnelson',
    maintainer_email='mjnelson@todo.todo',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={'console_scripts': [],
    },
)
```

---

<h1>Updating setup.py (cont.)</h1>

```py {all|19-21}
from setuptools import find_packages, setup

package_name = 'intro_to_ros'
setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages', ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='mjnelson',
    maintainer_email='mjnelson@todo.todo',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={'console_scripts': [
            'pubsub = intro_to_ros.pubsub:main',
        ],
    },
)
```

---

<h1>Compiling the Package</h1>

<ul>
    <li>Packages must be compiled in the ROS2 workspace before any nodes are usable.</li>
    <li>Packages must be compiled from the workspace's directory; e.g., ~/avuc_ws</li>
    <li>Packages can be compiled with additional arguments.
    <ul>
        <li>The <strong>--packages-select</strong> argument specifies which packages should be compiled.</li>
        <li>The <strong>--symlink-install</strong> argument creates symbolic links between the currently existing package files in src/ and the respective build/ and install/ files.</li>
        <li>If new files are added to a package that is compiled using --symlink-install, the package will need to be recompiled.</li>
    </ul></li>
</ul>

```zsh
chmod +x ~/auvc_ws/src/auvc_coursework/intro_to_ros/intro_to_ros/pubsub.py
cd ~/auvc_ws && colcon build --packages-select intro_to_ros
```
