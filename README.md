# Payment Test Script - Setup Guide

## Overview

This project uses Robot Framework to test a local Payment UI. Before running any tests, you must configure the `BASE_URL` to point to the correct local HTML file and run a mock server.

> 📁 **Manual Test Cases**  
Manual test case files are located in the `Test Case` folder.
---

## Setup Instructions

1. Update 'BASE_URL'
Set the `${BASE_URL}` variable to the full path of your local HTML file. This is typically done in your `.robot` test file or a shared resource file:

```robot
${BASE_URL}    file:///D:/RobotFramework/ui/payment_ui.html

2. Start the Mock Server
   python mockup_server.py

3. Run the Tests
   robot payment_test.robot

![Test Screenshot](https://github.com/user-attachments/assets/76ab2a4a-c965-4f50-bb8e-0fd557c1727c)
![image](https://github.com/user-attachments/assets/338bdb5e-0e49-4229-97bf-7b987d0e50f8)


