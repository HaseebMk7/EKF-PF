# Mobile Robot Localization using EKF and Particle Filter (PF)

This project implements and compares two probabilistic algorithms for localizing a mobile robot in a 2D soccer field: **Extended Kalman Filter (EKF)** and **Particle Filter (PF)**.

The robot uses noisy odometry and bearing-only observations of known landmarks to estimate its pose.

## Repository Structure

```
EKF-PF/
├── *.py                 # All source code files (EKF, PF, models, main runner)
├── Dockerfile           # Docker container definition to run everything easily
├── requirements.txt     # Python dependencies
├── output_plots/        # Screenshots and result visualizations from EKF & PF
├── ekf_pf_REPORT.pdf    # Final report detailing theory, implementation & results
```


## Project Files

| File | Description |
|------|-------------|
| `localization.py` | Main entry point for running experiments with EKF or PF |
| `ekf.py`          | EKF implementation (prediction + correction) |
| `pf.py`           | Particle Filter implementation (motion sampling, weighting, resampling) |
| `soccer_field.py` | Models for motion, observation, noise, Jacobians |
| `utils.py`        | Helper functions like angle normalization, plotting |
| `policies.py`     | Robot motion policy (you can ignore this) |
| `plotting_ekf.py` | Batch runs of EKF over different noise settings |
| `plotting_pf.py`  | Batch runs of PF with varying particle count and noise |


## Report and Results

- `ekf_pf_report.pdf` includes:
  - Theory and equations for EKF & PF
  - Implementation details
  - Experimental results and visualizations
  - Discussion on accuracy, noise sensitivity, and particle count

- `output_plots/` contains all graphs and screenshots used in the report.


## Running without Docker

You can also run the filters manually (if Python + dependencies are installed):

```bash
python localization.py ekf --plot
python localization.py pf --plot
python localization.py --plot none  # Just ground truth and odometry
```

Noise parameters:
```bash
python localization.py ekf --data-factor 4 --filter-factor 4
python localization.py pf --num-particles 100
```

## Running with Docker

Ensure Docker is installed and running. Then, from the root folder (`EKF-PF/`), run:

### Step 1: Build the Docker image

```bash
docker build -t robot-localizer .
```

### Step 2: Run both EKF and PF

```bash
docker run --rm robot-localizer
```

This will output results from EKF followed by PF with a clean separation.

To run PF separately or change parameters, use:

```bash
docker run --rm robot-localizer python localization.py pf --plot
```


## Notes

- EKF is efficient but sensitive to linearization and noise tuning.
- PF handles non-Gaussian posteriors and multimodal beliefs but is computationally heavier.
- Both filters were implemented using a shared motion and observation model (`soccer_field.py`).
