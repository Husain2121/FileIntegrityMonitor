

<h1>File Integrity Monitor</h1>

📘 <a href="https://docs.google.com/document/d/1Ini71b8nt8m4BT8jctheLX9zfAWmwDPiwqz31xxJfZU/edit?usp=sharing">Full Step-by-Step Tutorial Documentation</a>

<h2>Description</h2>
The project consists of a PowerShell-based File Integrity Monitoring System that was designed to protect system integrity by detecting unauthorized file creation, modification, and deletion. The solution establishes a trusted baseline using SHA-512 cryptographic hashing and performs ongoing comparisons of live file states to known-good values in order to find integrity violations in near real time. The environment includes a monitored file directory, a baseline hash store, and a continuous monitoring loop that assesses file changes at regular intervals. Alerts will be generated via severity-based console output in support of rapid investigation and incident response. This project will be presenting core cybersecurity principles, which concern the Integrity pillar of the CIA triad, and practical skills regarding PowerShell scripting, cryptographic hashing, detection logic, and security monitoring workflows within a realistic host-based security context.


<br />

<h2>Languages and Utilities Used</h2>

- <b>PowerShell</b>
- <b>Windows File System (NTFS)</b>


<h2>Eniviorments Used</h2>

- <b>Windows OS</b>
- <b>PowerShell Execution Enviorment (ISE)</b>




