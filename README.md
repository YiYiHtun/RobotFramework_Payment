# Payment Test Script - Setup Guide

## Overview

This project uses Robot Framework to test a local Payment UI. Before running any tests, you must configure the `BASE_URL` to point to the correct local HTML file and run a mock server.

> 📁 **Manual Test Cases**  
Manual test case files are located in the `Test Case` folder.
---

## Setup Instructions

1. Update 'BASE_URL'
   Set the `${BASE_URL}` variable to the full path of your local HTML file. This is typically done in your `.robot` test file or a shared resource file:
   ${BASE_URL}    file:///D:/RobotFramework/ui/payment_ui.html

2. Start the Mock Server
   python mockup_server.py

3. Run the Tests
   robot payment_test.robot

![Test Screenshot](https://github.com/user-attachments/assets/284c2913-4b41-4a5c-ba14-fa4c1af6cf7c)

![image](https://github.com/user-attachments/assets/0c7c80c5-e8d9-4549-a064-ff0431291458)

![image](https://github.com/user-attachments/assets/f85330e9-4b34-4493-acd3-313d86531047)


