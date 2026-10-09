# ⚡ Hotspot Data Saver

### A lightweight Windows hotspot monitoring utility built with PowerShell and Task Scheduler.

**Stop guessing what's happening when your laptop connects to your mobile hotspot.**

Hotspot Data Saver detects your active Wi-Fi network, checks whether your mobile hotspot is configured as a metered connection, and logs the results automatically.

Combined with Windows' built-in metered connection feature, this setup can help reduce unnecessary background data consumption without disabling important Windows security services.

## 🎯 The Problem

When using a mobile hotspot to connect a Windows laptop to the internet, background activities such as Windows Update, cloud synchronization, and application downloads can consume valuable mobile data.

Manually stopping Windows services every time isn't practical and may interfere with security updates.

I built this project to explore a safer, lightweight solution using PowerShell automation.

## ✨ Features

- **Wi-Fi detection:** Identifies the currently connected wireless network.
- **Hotspot recognition:** Compares the connected SSID with a configured hotspot name.
- **Metered connection monitoring:** Checks whether Windows considers the active connection metered.
- **Automatic execution:** Uses Windows Task Scheduler to run at login and periodically.
- **Activity logging:** Records connection details and metered status.
- **Lightweight:** No third-party dependencies or continuously running application.
- **Security-conscious:** Does not disable Windows Update, BITS, or Microsoft Defender.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| PowerShell | Network detection and automation |
| Windows Runtime Networking API | Connection and metered status information |
| Windows Task Scheduler | Scheduled execution |
| Windows Metered Connection | Background data-saving configuration |
| Windows 10/11 | Target operating system |

## 📂 Project Structure

```text
Hotspot-Data-Saver/
│
├── HotspotDataSaver.ps1
├── README.md
├── LICENSE
└── docs/
    └── setup-guide.pdf
```

*The structure above is recommended. Add the files you want to distribute.*

## 🚀 Installation Guide

### Step 1 — Download the script

Clone the repository:

```powershell
git clone https://github.com/dhayalan611/Hotspot-Data-Saver.git
```

Or download the ZIP from GitHub.

Create the directory:

```powershell
New-Item -ItemType Directory -Path "C:\Scripts" -Force
```

Copy `HotspotDataSaver.ps1` into `C:\Scripts`.

### Step 2 — Configure your hotspot

Open `HotspotDataSaver.ps1` using Notepad or VS Code.

Find:

```powershell
$HotspotSSID = "YOUR_HOTSPOT_NAME"
```

Replace the placeholder with your phone's Wi-Fi hotspot name.

For example:

```powershell
$HotspotSSID = "MyPhoneHotspot"
```

Save the file.

### Step 3 — Enable metered connection

1. Connect your laptop to your mobile hotspot.
2. Open **Settings → Network & Internet → Wi-Fi**.
3. Select your connected hotspot.
4. Enable **Metered connection**.
5. Open **Windows Update → Advanced options**.
6. Disable **Download updates over metered connections**.

Windows normally remembers the metered setting for saved Wi-Fi networks.

### Step 4 — Test the script

Open Windows PowerShell and execute:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Scripts\HotspotDataSaver.ps1"
```

The script creates a log file at:

```text
%LOCALAPPDATA%\HotspotDataSaver\hotspot.log
```

Example output:

```text
2026-10-09T21:45:37 - Connected Wi-Fi: MyPhoneHotspot
2026-10-09T21:45:37 - Hotspot is already metered.
```

### Step 5 — Automate with Task Scheduler

Press `Win + R`, enter `taskschd.msc`, and open Task Scheduler.

Select **Create Task**.

Under **General**:

- Name: `Hotspot Data Saver`
- Select: `Run only when user is logged on`

Under **Triggers**, create:

- Trigger 1: At log on
- Trigger 2: Daily, repeat every 5 minutes indefinitely

Under **Actions**, select **New → Start a program**.

Program/script:

```text
powershell.exe
```

Add arguments:

```text
-NoProfile -NonInteractive -ExecutionPolicy Bypass -File "C:\Scripts\HotspotDataSaver.ps1"
```

Under **Conditions**, disable the AC-power-only requirement if you want checks to run while using your laptop battery.

Save the task.

### Step 6 — Verify automation

In Task Scheduler:

1. Find `Hotspot Data Saver`.
2. Right-click and select **Run**.
3. Open the log file.
4. Confirm that the connected SSID and metered status appear.

Your scheduled monitoring is now configured.

## 🔄 How It Works

```text
Windows Login / Scheduled Trigger
               |
               v
       PowerShell Script
               |
               v
      Detect Active Wi-Fi
               |
               v
     Compare Connected SSID
               |
       +-------+-------+
       |               |
       v               v
  Mobile Hotspot    Other Wi-Fi
       |               |
       v               v
  Check Metered     Log Network
     Status           Status
       |               |
       +-------+-------+
               |
               v
          Write Log
```

## 🔐 Security and Limitations

This project is designed for monitoring, not aggressive Windows service modification.

**Important limitations:**

- The script does not automatically enable or disable metered connections.
- It does not stop Windows Update or BITS.
- It does not block all background internet traffic.
- Windows may still download critical updates or security-related data.
- Some third-party applications may ignore metered connection preferences.
- Scheduled checks occur while the task is enabled and the configured user session is available.

The actual data-saving behavior comes from Windows' metered connection configuration.

For security, avoid permanently disabling Windows Update, Microsoft Defender, or other essential Windows services.

## 🧪 Testing

The project was initially tested with a Windows laptop connected to a mobile hotspot.

The following behaviors were verified:

- Connected hotspot SSID detected successfully.
- Metered connection status reported correctly.
- Log file generated successfully.
- Multiple script executions recorded.
- Reduced mobile data usage observed after enabling Windows metered connection settings.

Results may vary depending on Windows configuration and installed applications.

## 🔮 Future Improvements

Potential future enhancements include:

- Network usage monitoring and reporting.
- Notifications when a hotspot isn't metered.
- Improved network-change detection.
- A simple desktop dashboard.
- Better error handling and log rotation.
- Multiple hotspot profile support.

## 👨‍💻 Author

**M. Dhayalan**

BICT (Hons) Undergraduate  
South Eastern University of Sri Lanka

Interested in Cybersecurity, Networking, and Automation.

**GitHub:** https://github.com/dhayalan611

## 📄 License

MIT License — see the `LICENSE` file.

---

**Built to solve a real-world problem while learning PowerShell, Windows networking, and task automation.**

⭐ If you find this project useful, consider starring the repository!
