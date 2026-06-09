# =========================================================
# STAGE 1: The Builder (The Workshop)
# =========================================================
FROM python:3.12-slim AS builder

WORKDIR /build

# Install any required system tools if needed (simulated)
RUN apt-get update && apt-get install -y --no-install-recommends gcc build-essential

# Copy the dependency list and compile/install packages locally into a temporary folder
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt


# =========================================================
# STAGE 2: The Final Runtime (The Showroom)
# =========================================================
FROM python:3.12-slim AS runner

# Create our unprivileged application user
RUN useradd -m odoo_user
WORKDIR /app

# Core Trick: Copy the installed python packages directly from the builder stage
COPY --from=builder --chown=odoo_user:odoo_user /root/.local /home/odoo_user/.local
COPY --chown=odoo_user:odoo_user server.py .

EXPOSE 8000

# Ensure the system path knows where to find the copied python user packages
ENV PATH=/home/odoo_user/.local/bin:$PATH

USER odoo_user

CMD ["python3", "server.py"]
