Markdown does not directly support CSS or inline styling like HTML. To arrange images in a grid-like format (e.g., 2 graphs per row), we can use a table layout. Here's how you can structure your README to achieve that:

---

# Velocity Control on 4-Wheel Driveline Model with PID Controller

## Case Studies

### Case 1 Torque in = 225 NM and Steering angle = 0 rad/s  
| **Longitudinal Velocity** | **Lateral Velocity** |
|---------------------------|-----------------------|
| ![Longitudinal Velocity](Results/case1/Vx.jpg) | ![Lateral Velocity](Results/case1/Vy.jpg) |

| **Pose (2D)**             | **Lateral Acceleration** |
|---------------------------|---------------------------|
| ![Pose (2D)](Results/case1/pose.jpg) | ![Lateral Acceleration](Results/case1/lat_accel.jpg) |

---

### Case 2 Torque in = 450 NM and Steering angle = 0 rad/s
| **Longitudinal Velocity** | **Lateral Velocity** |
|---------------------------|-----------------------|
| ![Longitudinal Velocity](Results/Case-2/Vx.jpg) | ![Lateral Velocity](Results/Case-2/Vy.jpg) |

| **Pose (2D)**             | **Lateral Acceleration** |
|---------------------------|---------------------------|
| ![Pose (2D)](Results/Case-2/pose.jpg) | ![Lateral Acceleration](Results/Case-2/Lat_acc.jpg) |

---

### Case 3 Torque in = 100 NM and Steering angle = 0.1 rad/s
| **Longitudinal Velocity** | **Lateral Velocity** |
|---------------------------|-----------------------|
| ![Longitudinal Velocity](Results/case-3/Vx.jpg) | ![Lateral Velocity](Results/case-3/Vy.jpg) |

| **Pose (2D)**             | **Lateral Acceleration** |
|---------------------------|---------------------------|
| ![Pose (2D)](Results/case-3/pose.jpg) | ![Lateral Acceleration](Results/case-3/lat_acc.jpg) |

---
### Case 3 Torque in = 100 NM and Steering angle = 0.1 rad/s Left Turn
| **Longitudinal Velocity** | **Lateral Velocity** |
|---------------------------|-----------------------|
| ![Longitudinal Velocity](Results/Case-4/Vx.jpg) | ![Lateral Velocity](Results/Case-4/Vy.jpg) |

| **Pose (2D)**             | **Lateral Acceleration** |
|---------------------------|---------------------------|
| ![Pose (2D)](Results/Case-4/pos.jpg) | ![Lateral Acceleration](Results/Case-4/lat_accel.jpg) |

---

## PID Tuning
| **PID Tuning - Graph 1** | **PID Tuning - Graph 2** |
|--------------------------|--------------------------|
| ![PID Tuning 1](Results/PID_tunning/Vel_graph.jpg) | ![PID Tuning 2](Results/PID_tunning2/Vx.jpg) |

---

This approach aligns images into a grid without relying on HTML-specific styling, ensuring compatibility with Markdown viewers such as GitHub. Replace `path/to/...` with the actual paths to your images.
