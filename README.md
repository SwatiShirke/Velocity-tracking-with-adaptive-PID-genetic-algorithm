Markdown does not directly support CSS or inline styling like HTML. To arrange images in a grid-like format (e.g., 2 graphs per row), we can use a table layout. Here's how you can structure your README to achieve that:

---

# Velocity Control on 4-Wheel Driveline Model with PID Controller

## Case Studies

### Case 1
| **Longitudinal Velocity** | **Lateral Velocity** |
|---------------------------|-----------------------|
| ![Longitudinal Velocity](Results/case1/Vx.jpg) | ![Lateral Velocity](path/to/case1_lateral.png) |

| **Pose (2D)**             | **Lateral Acceleration** |
|---------------------------|---------------------------|
| ![Pose (2D)](Results/case1/Vy.jpg) | ![Lateral Acceleration](path/to/case1_lateral_acceleration.png) |

---

### Case 2
| **Longitudinal Velocity** | **Lateral Velocity** |
|---------------------------|-----------------------|
| ![Longitudinal Velocity](Results/case1/pose.jpg) | ![Lateral Velocity](path/to/case2_lateral.png) |

| **Pose (2D)**             | **Lateral Acceleration** |
|---------------------------|---------------------------|
| ![Pose (2D)](path/to/case2_pose2d.png) | ![Lateral Acceleration](path/to/case2_lateral_acceleration.png) |

---

## PID Tuning
| **PID Tuning - Graph 1** | **PID Tuning - Graph 2** |
|--------------------------|--------------------------|
| ![PID Tuning 1](Results/case1/lat_accel.jpg) | ![PID Tuning 2](path/to/pid_tuning2.png) |

---

This approach aligns images into a grid without relying on HTML-specific styling, ensuring compatibility with Markdown viewers such as GitHub. Replace `path/to/...` with the actual paths to your images.
