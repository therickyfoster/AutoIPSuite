echo ""
    echo -e "${BLUE}Repository:${NC} ${REPOSITORY_URL}"
    echo -e "${BLUE}Contact:${NC} ${CONTACT_EMAIL}"
    echo ""
    echo -e "${GREEN}🌍 Together, we restore the planet! 🌍${NC}"
    echo ""
}

# Function to create additional example implementations
create_example_implementations() {
    print_info "Creating example implementations..."
    
    # Create basic sensor network example
    mkdir -p examples/basic_deployment/simple_sensor_network
    cat > examples/basic_deployment/simple_sensor_network/main.py << 'EOF'
#!/usr/bin/env python3
"""
Simple Sensor Network Example
Demonstrates basic temperature and humidity monitoring
"""

import asyncio
import random
import json
from datetime import datetime
from typing import Dict, Any

class SensorNode:
    """Simulated sensor node"""
    
    def __init__(self, node_id: str, location: str):
        self.node_id = node_id
        self.location = location
        self.is_active = False
        
    async def read_sensors(self) -> Dict[str, Any]:
        """Simulate sensor reading"""
        # Simulate sensor values
        temperature = 20 + random.uniform(-5, 5)
        humidity = 60 + random.uniform(-20, 20)
        
        return {
            "sensor_id": self.node_id,
            "location": self.location,
            "timestamp": datetime.now().isoformat(),
            "readings": {
                "temperature": {
                    "value": round(temperature, 2),
                    "unit": "celsius"
                },
                "humidity": {
                    "value": round(humidity, 2),
                    "unit": "percent"
                }
            }
        }
        
    async def start(self):
        """Start sensor node"""
        self.is_active = True
        print(f"✅ Sensor node {self.node_id} started at {self.location}")
        
    async def stop(self):
        """Stop sensor node"""
        self.is_active = False
        print(f"🛑 Sensor node {self.node_id} stopped")

class SensorNetwork:
    """Simple sensor network coordinator"""
    
    def __init__(self):
        self.nodes = []
        self.data_buffer = []
        self.is_running = False
        
    def add_node(self, node: SensorNode):
        """Add sensor node to network"""
        self.nodes.append(node)
        print(f"📡 Added sensor node: {node.node_id}")
        
    async def start(self):
        """Start the sensor network"""
        print("🌍 Starting AutoIPSuite Simple Sensor Network")
        print("=" * 50)
        
        # Start all nodes
        for node in self.nodes:
            await node.start()
            
        self.is_running = True
        
        # Start data collection
        asyncio.create_task(self.collect_data())
        
    async def collect_data(self):
        """Collect data from all sensors"""
        while self.is_running:
            for node in self.nodes:
                if node.is_active:
                    data = await node.read_sensors()
                    self.data_buffer.append(data)
                    self.display_reading(data)
                    
            # Save data periodically
            if len(self.data_buffer) >= 10:
                await self.save_data()
                self.data_buffer = []
                
            await asyncio.sleep(5)  # Read every 5 seconds
            
    def display_reading(self, data: Dict[str, Any]):
        """Display sensor reading"""
        readings = data["readings"]
        temp = readings["temperature"]["value"]
        humidity = readings["humidity"]["value"]
        
        print(f"📊 [{data['sensor_id']}] {data['location']}: "
              f"🌡️ {temp}°C | 💧 {humidity}%")
        
    async def save_data(self):
        """Save collected data to file"""
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f"sensor_data_{timestamp}.json"
        
        with open(filename, 'w') as f:
            json.dump(self.data_buffer, f, indent=2)
            
        print(f"💾 Saved {len(self.data_buffer)} readings to {filename}")
        
    async def stop(self):
        """Stop the sensor network"""
        self.is_running = False
        
        for node in self.nodes:
            await node.stop()
            
        print("🌍 Sensor network stopped")

async def main():
    """Main entry point"""
    # Create sensor network
    network = SensorNetwork()
    
    # Add sensor nodes
    network.add_node(SensorNode("SN001", "Community Garden"))
    network.add_node(SensorNode("SN002", "Greenhouse"))
    network.add_node(SensorNode("SN003", "Outdoor Field"))
    
    # Start network
    await network.start()
    
    try:
        # Run for demonstration (in production, this would run indefinitely)
        await asyncio.sleep(30)  # Run for 30 seconds
    except KeyboardInterrupt:
        print("\n⚠️ Interrupted by user")
    finally:
        await network.stop()

if __name__ == "__main__":
    print("🌍 AutoIPSuite - Simple Sensor Network Example")
    print("This demonstrates basic environmental monitoring")
    print("")
    
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\n✨ Example completed")
EOF
    print_status "Created simple sensor network example"
    
    # Create requirements for the example
    cat > examples/basic_deployment/simple_sensor_network/requirements.txt << 'EOF'
# Simple Sensor Network Example Requirements
asyncio
EOF
    
    # Create README for the example
    cat > examples/basic_deployment/simple_sensor_network/README.md << 'EOF'
# Simple Sensor Network Example

## Overview
This example demonstrates a basic sensor network implementation using AutoIPSuite principles. It simulates multiple sensor nodes collecting temperature and humidity data.

## Features
- Multiple sensor nodes with unique IDs and locations
- Simulated temperature and humidity readings
- Periodic data collection and storage
- JSON data export
- Real-time console display

## Running the Example

### Prerequisites
- Python 3.9+
- No external dependencies (uses standard library only)

### Execution
```bash
python main.py
```

The example will:
1. Create 3 sensor nodes
2. Collect data every 5 seconds
3. Display readings in real-time
4. Save data to JSON files periodically
5. Run for 30 seconds (or until interrupted)

## Sample Output
```
📊 [SN001] Community Garden: 🌡️ 22.3°C | 💧 65.2%
📊 [SN002] Greenhouse: 🌡️ 24.7°C | 💧 78.5%
📊 [SN003] Outdoor Field: 🌡️ 18.9°C | 💧 55.8%
```

## Extending the Example
- Add more sensor types (soil moisture, light, CO2)
- Implement data visualization
- Add MQTT communication
- Connect to real hardware sensors
- Implement data analysis and alerts

## Next Steps
After running this example, try:
1. `community_garden` - More complex monitoring
2. `water_quality_monitoring` - Specialized sensors
3. Integration with the main AutoIPSuite framework
EOF
    print_status "Created simple sensor network documentation"
}

# Function to create deployment scripts
create_deployment_scripts() {
    print_info "Creating deployment scripts..."
    
    # Create deployment script for local development
    cat > scripts/deployment/deploy_local.sh << 'EOF'
#!/bin/bash

# AutoIPSuite Local Deployment Script
# For development and testing purposes

set -e

echo "🌍 AutoIPSuite Local Deployment"
echo "================================"

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "❌ Virtual environment not found. Run setup first:"
    echo "   ./scripts/setup/initialize_project.sh"
    exit 1
fi

# Activate virtual environment
source venv/bin/activate

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "⚠️ Docker not found. Some services may not work."
else
    echo "✅ Docker found"
    
    # Start supporting services
    echo "🚀 Starting supporting services..."
    docker-compose up -d postgres redis mqtt
    
    # Wait for services to be ready
    echo "⏳ Waiting for services to be ready..."
    sleep 5
fi

# Run database migrations
echo "🗄️ Running database migrations..."
python -c "
from src.config.settings import get_settings
from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base

settings = get_settings()
engine = create_engine(settings.database_url)
Base = declarative_base()
Base.metadata.create_all(engine)
print('✅ Database ready')
"

# Start the application
echo "🌍 Starting AutoIPSuite..."
python src/main.py
EOF
    chmod +x scripts/deployment/deploy_local.sh
    print_status "Created local deployment script"
    
    # Create production deployment script
    cat > scripts/deployment/deploy_production.sh << 'EOF'
#!/bin/bash

# AutoIPSuite Production Deployment Script
# For deploying to production environments

set -e

echo "🌍 AutoIPSuite Production Deployment"
echo "====================================="

# Configuration
DEPLOY_ENV=${DEPLOY_ENV:-production}
DEPLOY_USER=${DEPLOY_USER:-autoip}
DEPLOY_HOST=${DEPLOY_HOST:-localhost}
DEPLOY_PATH=${DEPLOY_PATH:-/opt/autoipsuite}

# Safety check
read -p "⚠️ Deploy to PRODUCTION? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
    echo "❌ Deployment cancelled"
    exit 1
fi

echo "📦 Building production image..."
docker build -t autoipsuite:production .

echo "🏷️ Tagging image..."
docker tag autoipsuite:production autoipsuite:$(date +%Y%m%d-%H%M%S)
docker tag autoipsuite:production autoipsuite:latest

echo "🚀 Deploying to $DEPLOY_HOST..."
if [ "$DEPLOY_HOST" != "localhost" ]; then
    # Remote deployment
    echo "📤 Pushing to registry..."
    # docker push your-registry/autoipsuite:latest
    
    # SSH and pull on remote
    ssh $DEPLOY_USER@$DEPLOY_HOST << 'REMOTE_SCRIPT'
        cd $DEPLOY_PATH
        docker-compose pull
        docker-compose up -d --remove-orphans
        docker-compose ps
REMOTE_SCRIPT
else
    # Local production deployment
    docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
fi

echo "✅ Deployment complete!"
echo "🔍 Check application at: http://$DEPLOY_HOST:8000"
EOF
    chmod +x scripts/deployment/deploy_production.sh
    print_status "Created production deployment script"
}

# Function to create documentation structure
create_documentation_structure() {
    print_info "Creating documentation structure..."
    
    # Create MkDocs configuration
    cat > mkdocs.yml << 'EOF'
site_name: AutoIPSuite Documentation
site_description: Planetary Restoration Framework Documentation
site_author: AutoIPSuite Community
site_url: https://github.com/therickyfoster/AutoIPSuite
repo_url: https://github.com/therickyfoster/AutoIPSuite
repo_name: AutoIPSuite

theme:
  name: material
  palette:
    - media: "(prefers-color-scheme: light)"
      scheme: default
      primary: green
      accent: light-green
      toggle:
        icon: material/brightness-7
        name: Switch to dark mode
    - media: "(prefers-color-scheme: dark)"
      scheme: slate
      primary: green
      accent: light-green
      toggle:
        icon: material/brightness-4
        name: Switch to light mode
  features:
    - navigation.instant
    - navigation.tracking
    - navigation.sections
    - navigation.expand
    - navigation.top
    - search.suggest
    - search.highlight
    - content.code.copy
  icon:
    repo: fontawesome/brands/github

plugins:
  - search
  - mermaid2

markdown_extensions:
  - admonition
  - codehilite
  - pymdownx.superfences:
      custom_fences:
        - name: mermaid
          class: mermaid
          format: !!python/name:pymdownx.superfences.fence_code_format
  - pymdownx.tabbed
  - pymdownx.details
  - pymdownx.emoji:
      emoji_index: !!python/name:materialx.emoji.twemoji
      emoji_generator: !!python/name:materialx.emoji.to_svg
  - toc:
      permalink: true

nav:
  - Home: index.md
  - Getting Started:
    - Quick Start: getting-started/quick-start.md
    - Installation: getting-started/installation.md
    - Configuration: getting-started/configuration.md
  - User Guides:
    - Basic Usage: user-guides/basic-usage.md
    - DAO Setup: user-guides/dao-setup.md
    - Sensor Networks: user-guides/sensor-networks.md
    - Data Analysis: user-guides/data-analysis.md
  - Technical Documentation:
    - Architecture: technical/architecture.md
    - API Reference: technical/api-reference.md
    - Database Schema: technical/database-schema.md
    - Security: technical/security.md
  - Hardware:
    - Sensor Nodes: hardware/sensor-nodes.md
    - Gateway Devices: hardware/gateway-devices.md
    - DIY Guide: hardware/diy-guide.md
  - Examples:
    - Simple Sensor Network: examples/simple-sensor.md
    - Community Garden: examples/community-garden.md
    - Advanced Projects: examples/advanced.md
  - Contributing:
    - Contribution Guide: contributing/guide.md
    - Code of Conduct: contributing/code-of-conduct.md
    - Development Setup: contributing/development.md
  - About:
    - Mission: about/mission.md
    - License: about/license.md
    - Contact: about/contact.md

extra:
  social:
    - icon: fontawesome/brands/github
      link: https://github.com/therickyfoster/AutoIPSuite
    - icon: fontawesome/solid/envelope
      link: mailto:admin@planetaryrestorationarchive.com
  
copyright: Copyright &copy; 2025 AutoIPSuite - Licensed under Hybrid Guardian License
EOF
    print_status "Created MkDocs configuration"
    
    # Create main documentation index
    cat > documentation/index.md << 'EOF'
# AutoIPSuite Documentation

## Welcome to the Planetary Restoration Framework

AutoIPSuite is a comprehensive framework for deploying, testing, and scaling real-world planetary restoration solutions. By combining technology, governance, and community action, we're building tools that empower anyone to contribute to healing our planet.

## 🌍 Our Mission

To create accessible, scalable technology that enables communities worldwide to:
- Monitor and improve their local environment
- Collaborate on restoration projects
- Share knowledge and resources
- Measure and verify positive impact
- Build sustainable, regenerative systems

## 🚀 Quick Links

- [Quick Start Guide](getting-started/quick-start.md) - Get up and running in minutes
- [Examples](examples/simple-sensor.md) - Learn by doing with practical examples
- [API Reference](technical/api-reference.md) - Complete API documentation
- [Contributing](contributing/guide.md) - Join our community of contributors

## 🌱 Key Features

### Modular Architecture
Build exactly what you need with our flexible component system.

### Decentralized Governance
Community-driven decision making through DAO integration.

### Real-time Monitoring
Comprehensive sensor networks with instant data analysis.

### Impact Verification
Transparent, measurable restoration outcomes tracked on-chain.

### Open Hardware
DIY-friendly designs for sensors and monitoring equipment.

## 📚 Documentation Structure

This documentation is organized into several sections:

- **Getting Started** - Installation, configuration, and your first deployment
- **User Guides** - Step-by-step guides for common tasks
- **Technical Documentation** - Architecture, APIs, and implementation details
- **Hardware** - Building and deploying physical monitoring systems
- **Examples** - Real-world implementations and use cases
- **Contributing** - How to contribute to the project
- **About** - Mission, license, and contact information

## 🤝 Community

Join our growing community of developers, environmentalists, and changemakers:

- [GitHub Repository](https://github.com/therickyfoster/AutoIPSuite)
- [Issue Tracker](https://github.com/therickyfoster/AutoIPSuite/issues)
- Email: admin@planetaryrestorationarchive.com

## 📄 License

AutoIPSuite is licensed under the Hybrid Guardian License, which allows:
- Free use for humanitarian and ecological efforts
- Commercial use with values-aligned revenue sharing
- Community governance of license terms

See [License](about/license.md) for full details.

---

*Built with 🌍 for planetary restoration by the global community.*
EOF
    print_status "Created documentation index"
}

# Function to verify installation
verify_installation() {
    print_info "Verifying installation..."
    
    local errors=0
    
    # Check Python version
    if command -v python3 &> /dev/null; then
        print_status "Python3 installed"
    else
        print_error "Python3 not found"
        ((errors++))
    fi
    
    # Check critical directories
    for dir in "src" "DAO_integration" "hardware" "simulations" "documentation"; do
        if [ -d "$dir" ]; then
            print_status "Directory $dir exists"
        else
            print_error "Directory $dir missing"
            ((errors++))
        fi
    done
    
    # Check critical files
    for file in "README.md" "LICENSE.md" "CONTRIBUTING.md" ".gitignore"; do
        if [ -f "$file" ]; then
            print_status "File $file exists"
        else
            print_error "File $file missing"
            ((errors++))
        fi
    done
    
    if [ $errors -eq 0 ]; then
        echo ""
        echo -e "${GREEN}✅ Installation verified successfully!${NC}"
        return 0
    else
        echo ""
        echo -e "${RED}❌ Installation verification failed with $errors errors${NC}"
        return 1
    fi
}

# Check if we're in the right directory
check_directory() {
    if [ -f "README.md" ] && grep -q "AutoIPSuite" README.md 2>/dev/null; then
        print_warning "AutoIPSuite files already exist. This will overwrite them."
        read -p "Continue? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Setup cancelled."
            exit 1
        fi
    fi
}

# Cleanup function
cleanup() {
    print_info "Cleaning up temporary files..."
    rm -f *.tmp *.temp 2>/dev/null
}

# Set trap for cleanup
trap cleanup EXIT

# Run main function with additional features
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    check_directory
    main
    create_example_implementations
    create_deployment_scripts
    create_documentation_structure
    verify_installation
    
    # Final message
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}     🌍 AutoIPSuite Setup Complete! 🌍${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${BLUE}Your planetary restoration framework is ready!${NC}"
    echo ""
    echo -e "${YELLOW}📋 Quick Start Commands:${NC}"
    echo -e "   ${GREEN}./scripts/setup/initialize_project.sh${NC} - Initialize environment"
    echo -e "   ${GREEN}source venv/bin/activate${NC}             - Activate Python environment"
    echo -e "   ${GREEN}python src/main.py${NC}                   - Run the application"
    echo -e "   ${GREEN}mkdocs serve${NC}                         - View documentation"
    echo ""
    echo -e "${YELLOW}📁 Key Directories:${NC}"
    echo -e "   ${BLUE}src/${NC}           - Core application code"
    echo -e "   ${BLUE}examples/${NC}      - Example implementations"
    echo -e "   ${BLUE}hardware/${NC}      - Hardware designs and firmware"
    echo -e "   ${BLUE}DAO_integration/${NC} - Governance components"
    echo ""
    echo -e "${YELLOW}📚 Resources:${NC}"
    echo -e "   Documentation: ${BLUE}documentation/${NC}"
    echo -e "   Examples:      ${BLUE}examples/basic_deployment/${NC}"
    echo -e "   Repository:    ${BLUE}${REPOSITORY_URL}${NC}"
    echo -e "   Contact:       ${BLUE}${CONTACT_EMAIL}${NC}"
    echo ""
    echo -e "${GREEN}Thank you for joining the planetary restoration movement!${NC}"
    echo -e "${GREEN}Together, we can heal our world. 🌱${NC}"
    echo ""
fi
