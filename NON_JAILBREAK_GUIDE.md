# Non-Jailbreak iOS App - Complete Guide

## What This Is

A **standalone iOS app** that works on ANY device without jailbreak using:
- ✅ SignKill
- ✅ TrollStore
- ✅ Any non-jailbroken iPhone/iPad

---

## Key Features

### What It CAN Do
- ✅ Memory scanning and reading
- ✅ Value finder and modifier
- ✅ Run within app sandbox
- ✅ UI for all controls
- ✅ Works on iOS 12.0+
- ✅ No jailbreak required!
- ✅ No computer needed for users

### What It CANNOT Do (vs Jailbreak)
- ❌ Hook other apps (PUBGM)
- ❌ Overlay on games
- ❌ Inject code into processes
- ❌ System-wide cheats
- ⚠️ Limited to app's own memory space

---

## Installation on Device

### For Non-Jailbroken Users

1. **Build the app:**
   ```bash
   Push to GitHub → GitHub Actions builds automatically
   Download .ipa from artifacts
   ```

2. **Install on device:**
   - **Option A: SignKill** (Easiest for most)
     - Install SignKill app
     - Open .ipa with SignKill
     - Done!
   
   - **Option B: TrollStore**
     - Install TrollStore App
     - Drag .ipa into TrollStore
     - Install
   
   - **Option C: AltStore**
     - Install AltStore on PC
     - Connect iPhone via USB
     - Install app via AltStore

3. **Grant permissions:**
   - App may require certain permissions
   - Accept when prompted

4. **Launch app:**
   - App icon appears on home screen
   - Open and use!

---

## For Jailbroken Devices (Also Works)

If device is jailbroken, you can:
1. Install this app version (easier UI)
2. Or use the original .deb version (more power)

---

## Architecture

```
AppDelegate.mm (entry point)
    ↓
UIScrollView with toggles
    ↓
Feature callbacks
    ↓
KittyMemory utilities
    ↓
Local memory operations
```

---

## Memory Utilities Available

From your existing code:
```cpp
#include "KittyMemory/KittyMemory.hpp"

// Use in app:
KittyMemory mem;
uint32_t value = 0;
mem.Read(address, &value, sizeof(value));
mem.Write(address, &value, sizeof(value));
```

---

## Files Structure

```
NonJailbreak/
├── AppDelegate.mm      - Main app entry
├── Info.plist         - App metadata
└── Makefile           - Build config

.github/workflows/
└── build-nonjailbreak.yml  - CI/CD pipeline
```

---

## Building Process

### Automated (Recommended)

1. Code in VS Code on Windows
2. Push to GitHub
3. GitHub Actions builds on macOS
4. Download .ipa from artifacts

```
VS Code (Windows)
    ↓ git push
GitHub
    ↓ workflow triggered
GitHub Actions (macOS)
    ↓ builds
Artifacts (.ipa)
    ↓ download
Install on device
```

---

## Advantages vs Jailbreak Version

| Feature | Jailbreak .deb | Non-Jailbreak App |
|---------|---|---|
| Requires Jailbreak | ❌ YES | ✅ NO |
| Works on ANY device | ❌ Only jailbroken | ✅ YES |
| Installation method | Sileo/Cydia | SignKill/TrollStore |
| Code complexity | High (hooking) | Lower (direct) |
| User needs computer | ❌ Maybe | ✅ Not really |
| Distribution | Repository | Direct .ipa file |

---

## Reusing Original Code

You can integrate:
- ✅ `KittyMemory` - Memory access
- ✅ `CustomView` - UI components
- ✅ `utils` - Helper functions
- ❌ `Dolphins.mm` - Remove (Substrate specific)
- ❌ `ESP` module - Rewrite for app context
- ❌ `Module` - Remove (tweak specific)

---

## Distribution

### Cloud Storage
```
1. Build .ipa
2. Upload to:
   - Google Drive
   - Dropbox
   - GitHub Releases
   - Your server

3. Share download link
4. Users download + install with SignKill/TrollStore
```

### GitHub Releases
```bash
# Automated release creation
1. Tag your release: v1.0
2. Upload .ipa to releases
3. Users download from GitHub
```

### Direct Installation
```
1. Connect iPhone via USB
2. Use tools like:
   - Apple Configurator
   - iMazing
   - AltStore
3. Sideload .ipa directly
```

---

## Differences from Original

### Before (Jailbreak)
```
Tweak hooks PUBGM
    ↓
Injects code into game process
    ↓
Full control over game
    ↓
Full features available
```

### Now (Non-Jailbreak)
```
Standalone app
    ↓
Runs in its own sandbox
    ↓
Can access own memory
    ↓
Limited but NO jailbreak needed!
```

---

## Next Steps

1. **Test build:**
   - Push to GitHub
   - Watch Actions tab
   - Download .ipa

2. **Install locally:**
   - Use SignKill/TrollStore
   - Test on device
   - Verify features work

3. **Distribute:**
   - Share .ipa file
   - Users install same way
   - They don't need jailbreak!

4. **Enhance:**
   - Add more features
   - Improve UI
   - Add game-specific utilities

---

## Troubleshooting

### Build fails?
- Check GitHub Actions logs
- Verify all files are committed
- Make sure branch is `main`

### App crashes?
- Check console output
- Verify permissions
- Test on device

### Cannot install?
- SignKill/TrollStore working?
- Device iOS version correct (12.0+)?
- Enough storage space?

---

## Cost

- ❌ NO jailbreak cost
- ❌ NO subscription needed
- ❌ NO AppStore fee needed
- ✅ COMPLETELY FREE

Users just need SignKill or TrollStore (free tools).

---

## Summary

You now have **two versions**:

1. **Jailbreak .deb** ← Maximum power
2. **Non-Jailbreak .ipa** ← Maximum compatibility

Choose what to distribute or support both!

---

**Ready to build?** 🚀

Push your changes and watch GitHub Actions build automatically!
