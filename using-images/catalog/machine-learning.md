# Machine Learning for z/OS

A fully configured z/OS environment for demonstrating AI/ML capabilities on IBM Z.

## Overview

This demo image showcases IBM's AI and machine learning capabilities on z/OS, demonstrating how organizations can leverage their existing z/OS data and infrastructure for modern AI/ML workloads without moving data off-platform.

**Key Value Proposition:**
- Keep data where it lives - no need to move sensitive data to external platforms
- Leverage z/OS security and compliance features for AI/ML workloads
- Integrate with existing z/OS applications and data sources
- Scale AI/ML workloads on enterprise-grade infrastructure

## What's Included

### Software Components

- **IBM Watson Machine Learning for z/OS** - Enterprise AI platform
- **Python 3.x** - Latest Python runtime for z/OS
- **Jupyter Notebooks** - Interactive development environment
- **TensorFlow** - Deep learning framework
- **scikit-learn** - Machine learning library
- **pandas** - Data manipulation and analysis
- **NumPy** - Numerical computing library

### Sample Datasets

- Customer transaction data (synthetic)
- Fraud detection training data
- Time series forecasting examples
- Classification problem datasets

### Pre-built Notebooks

- **Getting Started** - Introduction to ML on z/OS
- **Data Exploration** - Working with z/OS datasets
- **Model Training** - Building and training models
- **Model Deployment** - Deploying models for inference
- **Integration Examples** - Connecting to CICS, Db2, and other z/OS services

## Demo Scenarios

### Scenario 1: Fraud Detection (20-30 minutes)

Demonstrate real-time fraud detection using transaction data.

**What to Show:**
1. Access z/OS transaction data directly
2. Train a fraud detection model using historical data
3. Deploy the model for real-time scoring
4. Integrate with existing CICS applications
5. Show security and audit capabilities

**Business Value:**
- Reduce fraud losses
- Improve customer experience
- Maintain data sovereignty
- Leverage existing z/OS infrastructure

### Scenario 2: Predictive Maintenance (25-35 minutes)

Show how ML can predict system failures and optimize maintenance.

**What to Show:**
1. Analyze system log data
2. Build predictive models for failure detection
3. Create maintenance schedules based on predictions
4. Integrate with operational dashboards
5. Demonstrate cost savings

**Business Value:**
- Reduce downtime
- Optimize maintenance costs
- Improve system reliability
- Proactive problem resolution

### Scenario 3: Customer Churn Prediction (20-30 minutes)

Predict customer churn using z/OS customer data.

**What to Show:**
1. Access customer data from Db2
2. Feature engineering and data preparation
3. Model training and evaluation
4. Deployment for batch and real-time scoring
5. Integration with CRM systems

**Business Value:**
- Improve customer retention
- Targeted marketing campaigns
- Revenue protection
- Data-driven decision making

## Getting Started

### Initial Setup

1. **Connect to the Environment**
   - Follow the [Connecting to z/OS](../connecting) guide
   - Ensure VPN connection is established

2. **Access Jupyter Notebooks**
   ```bash
   # SSH to z/OS
   ssh zosadmn@<your-zos-ip>
   
   # Start Jupyter
   jupyter notebook --ip=0.0.0.0 --port=8888
   ```

3. **Open Sample Notebooks**
   - Navigate to `/u/zosadmn/notebooks/`
   - Start with `01-getting-started.ipynb`

### Quick Demo Path

For a 15-minute quick demo:
1. Open the fraud detection notebook
2. Show data access from z/OS datasets
3. Run pre-trained model inference
4. Demonstrate integration with CICS transaction

## Configuration Details

### Python Environment

- **Location**: `/usr/lpp/IBM/cyp/v3r13/pyz`
- **Version**: Python 3.13
- **Virtual Environments**: Pre-configured in `/u/zosadmn/venv/`

### Watson Machine Learning

- **Installation Path**: `/usr/lpp/IBM/wml`
- **Configuration**: `/etc/wml/config.yaml`
- **Model Repository**: `/u/zosadmn/models/`

### Data Access

- **Db2 Connection**: Pre-configured JDBC connection
- **VSAM Access**: Python libraries for VSAM file access
- **Dataset Access**: z/OS dataset utilities available

## Tips & Best Practices

### For Effective Demonstrations

1. **Start with Business Value** - Lead with business outcomes, not technology
2. **Use Real-World Examples** - Relate scenarios to audience's industry
3. **Show Data Sovereignty** - Emphasize keeping data on z/OS
4. **Highlight Integration** - Demonstrate connections to existing z/OS apps
5. **Discuss Security** - Showcase z/OS security features for AI/ML

### Common Pitfalls to Avoid

- Don't get too technical too quickly
- Avoid comparing to cloud-only solutions negatively
- Don't skip the "why z/OS" conversation
- Ensure network connectivity before demo
- Have backup notebooks ready

### Performance Considerations

- Pre-load datasets before demonstrations
- Use pre-trained models for quick demos
- Monitor resource usage during demos
- Clear notebook outputs between sessions

## Technical Reference

### System Requirements

- **Memory**: 8GB minimum for ML workloads
- **Storage**: 50GB for datasets and models
- **Network**: VPN access required
- **Browser**: Chrome or Firefox for Jupyter

### Supported Frameworks

| Framework | Version | Purpose |
|-----------|---------|---------|
| TensorFlow | 2.x | Deep learning |
| scikit-learn | 1.x | Traditional ML |
| XGBoost | Latest | Gradient boosting |
| PyTorch | 2.x | Deep learning |

### Data Sources

- Db2 for z/OS databases
- VSAM files
- Sequential datasets
- Unix System Services files
- External APIs (via REST)

## Troubleshooting

### Jupyter Won't Start

```bash
# Check if port is already in use
netstat -an | grep 8888

# Kill existing process if needed
ps -ef | grep jupyter
kill -9 <pid>

# Restart Jupyter
jupyter notebook --ip=0.0.0.0 --port=8888
```

### Model Training Fails

- Check available memory: `df -h`
- Verify dataset access permissions
- Review Python package versions
- Check error logs in `/u/zosadmn/logs/`

### Connection Issues

- Verify VPN connection
- Check firewall rules
- Confirm z/OS IP address
- Test SSH connectivity first

## Additional Resources

- [IBM Watson Machine Learning for z/OS Documentation](https://www.ibm.com/docs/en/wml-for-zos)
- [Python on z/OS Guide](https://www.ibm.com/docs/en/python-zos)
- [Connecting to z/OS](../connecting)
- [FAQs](../../reference/faqs)

## Support

For technical issues or questions:
- TechZone Support: For provisioning and access issues
- WSC Team: For demo content and scenarios
- IBM Documentation: For product-specific questions