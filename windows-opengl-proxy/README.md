# Windows OpenGL Proxy Helper

A helper utility for installing and restoring a proxy `opengl32.dll` for system-wide OpenGL tracing and debugging on Windows.

## Quick Start

### 1. Build or obtain the proxy OpenGL DLL

Place your custom OpenGL proxy DLLs in the following structure:

```text
.
├── proxy_opengl32.bat
├── restore_opengl32.bat
├── x32-bit
│   └── opengl32.dll
└── x64-bit
    └── opengl32.dll
```

### 2. Install the proxy DLL

Run:

```bat
proxy_opengl32.bat
```

The script will:

- Request Administrator privileges if needed
- Backup the original system OpenGL DLL
- Install the proxy DLL into:
  - `C:\Windows\System32`
  - `C:\Windows\SysWOW64`

### 3. Run the target application

Launch the OpenGL application you want to trace or debug.

### 4. Restore the original system DLL

Run:

```bat
restore_opengl32.bat
```

The script will restore the original Windows OpenGL DLLs from the backups created during installation.

---

## Scripts

### proxy_opengl32.bat

Installs custom OpenGL proxy DLLs into:

- `C:\Windows\System32` (64-bit)
- `C:\Windows\SysWOW64` (32-bit)

The script:

- Automatically requests Administrator privileges through UAC
- Creates a backup named `opengl32_orig.dll`
- Replaces the system OpenGL DLL with the supplied proxy DLL

### restore_opengl32.bat

Restores the original OpenGL DLLs from the backups created during installation.

---

## Warning

⚠️ Experimental utility.

This tool modifies Windows system files and should only be used for:

- OpenGL tracing
- Graphics driver debugging
- API interception
- Research and development

Improper use may:

- Prevent OpenGL applications from launching
- Cause graphics-related instability
- Interfere with graphics driver updates
- Require manual system recovery

Use at your own risk.

It is strongly recommended to:

- Create a system restore point before use
- Keep backups of the original DLLs
- Use only trusted proxy DLLs

---

## Disclaimer

This utility is provided as-is, without warranty of any kind.

The author assumes no responsibility for system instability, software malfunction, data loss, or other issues resulting from the use of these scripts.
