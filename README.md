# Bill Cobb's Vehicle Dynamics Professionals' Challenge

A series of challenges in vehicle dynamics design and produced by Bill Cobb for
the Vehicle Dynamics Professionals' Facebook group.

## Challenges

The challenges focus on treatment of standardized vehicle dynamics tests. The
challenges make extensive use the cornering compliance concept.

The challenges were posted on the Vehicle Dynamics Professionals's Facebook
group over the course of July 11-12th, 2024.

The simulation data for each challenge is provided in the `data` folder.

### Challenge 1: constant steer understeer gradient test

From a constant steer, variable speed understeer gradient test, show a plot of
the understeer function vs. lateral acceleration showing the understeer
gradient at a lateral acceleration of 0.15 G.

The challenge data is available in `data/marc1.txt`.

<details>
<summary>Available data channels</summary>

| Time | Lat. Accel. | Run # | Chassis slip angle | Vehicle speed | Steering wheel angle | Yaw Velocity |
| :--: | :---------: | :---: | :----------------: | :-----------: | :------------------: | :----------: |
|  ✅  |     ❌      |  ❌   |         ❌         |      ✅       |          ❌          |      ✅      |

</details>

<details>
<summary>Vehicle parameters</summary>

| Parameter | Value | Unit |
| --------- | ----- | ---- |
| Wheelbase | 2745  | mm   |

</details>

### Challenge 2: on-centre chirp steer test

From an on-centre chirp steer test at constant speed, show a Bode plot of the
yaw velocity by steer response and compute the following metrics.

- Understeer gradient
- Steady-state gain
- Peak gain
- Frequency at peak gain
- Ratio of peak to steady-state gain
- Bandwidth

The challenge data is available in `data/marc2.txt`.

<details>
<summary>Available data channels</summary>

| Time | Lat. Accel. | Run # | Chassis slip angle | Vehicle speed | Steering wheel angle | Yaw Velocity |
| :--: | :---------: | :---: | :----------------: | :-----------: | :------------------: | :----------: |
|  ✅  |     ❌      |  ❌   |         ❌         |      ✅       |          ✅          |      ✅      |

</details>

<details>
<summary>Vehicle parameters</summary>

| Parameter      | Value | Unit |
| -------------- | ----- | ---- |
| Wheelbase      | 2745  | mm   |
| Steering ratio | 20    | -    |
| Mass, front    | 1000  | kg   |
| Mass, rear     | 600   | kg   |

</details>

### Challenge 3: constant radius understeer gradient test

From a constant radius understeer gradient test, show a plot of the understeer
function and cornering compliances vs. lateral acceleration. Compute the
tangent speed of the vehicle under test.

The challenge data is available in `data/marc3.txt`.

<details>
<summary>Available data channels</summary>

| Time | Lat. Accel. | Run # | Chassis slip angle | Vehicle speed | Steering wheel angle | Yaw Velocity |
| :--: | :---------: | :---: | :----------------: | :-----------: | :------------------: | :----------: |
|  ✅  |     ✅      |  ✅   |         ✅         |      ✅       |          ✅          |      ✅      |

</details>

<details>
<summary>Vehicle parameters</summary>

| Parameter      | Value | Unit |
| -------------- | ----- | ---- |
| Wheelbase      | 2745  | mm   |
| Steering ratio | 20    | -    |
| Mass, front    | 1000  | kg   |
| Mass, rear     | 600   | kg   |

</details>

### Challenge 4: constant speed ramp steer understeer gradient test

From a constant speed, variable steer gradient test, show a plot of the
understeer function and cornering compliances vs. lateral acceleration.

The challenge data is available in `data/marc4.txt`.

<details>
<summary>Available data channels</summary>

| Time | Lat. Accel. | Run # | Chassis slip angle | Vehicle speed | Steering wheel angle | Yaw Velocity |
| :--: | :---------: | :---: | :----------------: | :-----------: | :------------------: | :----------: |
|  ✅  |     ✅      |  ❌   |         ❌         |      ✅       |          ✅          |      ❌      |

</details>

<details>
<summary>Vehicle parameters</summary>

| Parameter      | Value | Unit |
| -------------- | ----- | ---- |
| Wheelbase      | 1745  | mm   |
| Steering ratio | 5     | -    |
| Mass, front    | 80    | kg   |
| Mass, rear     | 120   | kg   |

</details>

### Challenge 5: constant speed step steer test

From a constant speed step steer test at varying steering magnitudes, show a
plot of the following metrics.

- Understeer function and cornering compliances vs. lateral acceleration
- Step rise time of the steer angle, yaw velocity, chassis slip angle, and lateral acceleration vs. lateral acceleration
- Step settling time of the yaw velocity, chassis slip angle, and lateral acceleration vs. lateral acceleration
- Step overshoot percentage of the yaw velocity, chassis slip angle, and lateral acceleration vs. lateral acceleration

The challenge data is available in `data/marc5.csv`.

<details>
<summary>Available data channels</summary>

| Time | Lat. Accel. | Run # | Chassis slip angle | Vehicle speed | Steering wheel angle | Yaw Velocity |
| :--: | :---------: | :---: | :----------------: | :-----------: | :------------------: | :----------: |
|  ✅  |     ✅      |  ✅   |         ✅         |      ✅       |          ✅          |      ✅      |

</details>

<details>
<summary>Vehicle parameters</summary>

| Parameter      | Value | Unit |
| -------------- | ----- | ---- |
| Wheelbase      | 2745  | mm   |
| Steering ratio | 20    | -    |
| Mass, front    | 1000  | kg   |
| Mass, rear     | 600   | kg   |

</details>

<details>
<summary>Additional notes</summary>

- Input steering is not an ideal Heaviside step function, but rather a sigmoid.
  Industry standard is to take the 50% point of the steering as t(0).

</details>

## Solutions

### Python

An implementation by @kktse written in Python is available in the `python`
folder. This solution is implemented in a Jupyter notebook and makes use of
polars, numpy, scipy, matplotlib and python-control.

Further details can be found in the README.md.

### MATLAB

An implementation by Bill Cobb written in MATLAB is available in the `matlab`
folder. These have been uploaded to the repository at the request the author.
