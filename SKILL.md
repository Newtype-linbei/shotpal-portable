---
name: shotpal
description: Deploy and troubleshoot ShotPal Portable with tools matched to the host system; open local video-review projects and run scene detection, transcription, downloads and source-owned exports. Use for the portable workspace, not native Mac app changes.
---

# ShotPal Portable

Deploy and operate the local browser-based video-review application. The agent handles setup, requested operations and troubleshooting; the user can use the interface independently while its Python service runs.

The product goal is an end-to-end workflow for **YouTube, Bilibili, Rednote (小红书) and Douyin (抖音)**: download the selected video, import playable media, recognize shots/subtitles/music, and present usable source-associated results and downloaded assets. Full deployment includes music identification and its original/instrumental audio workflow, not just the video viewer. Verify the [platform and result acceptance criteria](references/workflow.md#platform-and-result-acceptance); URL recognition, installed tools or a successful model probe alone do not fulfill this goal. Run only the subset the user requests, and report unverified platforms/features explicitly.

## Start with the requested task

| Task | Read |
| --- | --- |
| Find required tools, model weights, exact download references and feature dependencies | [dependency inventory](models/README.md) |
| Reproduce local recognition settings or tune models for a new system | [parameter reference](models/PARAMETERS.md), including active-versus-reference differences |
| Deploy, choose dependencies, or repair an unfamiliar failure | [adaptive setup](references/adaptive-setup.md), then [installer mechanics](references/setup.md) |
| Use the Windows x64 setup helper | [Windows setup](references/windows-setup.md) |
| Carry out the full import-to-export workflow | [workflow](references/workflow.md) |
| Understand or modify the application | [architecture](references/architecture.md) |
| Change UI, progress, covers or recovery behavior | [operating contracts](references/operating-contracts.md); [interface details](references/interface.md) as needed |
| Work with disk projects, migration or file ownership | [portable projects](references/portable-projects.md) and [file management](references/file-management.md) |
| Prepare supplied shots, transcripts or other analysis | [data contract](references/data.md) |

Read only the relevant references. Current operating contracts supersede historical examples in the detailed references.

## Deploy and launch

Detect the actual OS/version, hardware and interpreter architecture, Python version and existing dependencies before choosing downloads. Use `scripts/runtime.py doctor`; reuse working managed, explicitly supplied or PATH tools. Python 3.10+ runs the service; the current Windows x64 setup helper requires 64-bit Python 3.11.

Install the components needed for the requested features within the user's existing authorization. Opening the viewer alone does not authorize large model downloads. Treat bundled recipes as starting points: diagnose a missing recipe or failure, consult current upstream sources, and select a verified compatible artifact, isolated environment or build route. Test the actual feature on the target system before declaring it ready. Preserve working components and active jobs. Ask only when a necessary decision, permission, credential or target-machine access is missing.

Commands run relative to this skill folder:

```sh
# Create a blank viewer or reopen the launcher's existing workspace.
python3 scripts/start_portable.py --workspace /path/to/workspace --no-browser

# Reopen an existing viewer with explicitly configured dependencies if needed.
python3 scripts/launch.py --workspace /path/to/workspace --no-browser
```

Use `--tools-dir`, `--model`, `--engine-python`, `--engine-vendor` and `--home` when the chosen configuration requires them. The launcher discovers managed tools and the Windows scene environment activated by its setup checks. No native ShotPal app is required.

Keep the service running. Reuse its saved port; do not silently change origins when the port is occupied. In Codex, open the printed localhost URL in the in-app browser, reuse a matching tab and verify it before handoff. Never open the HTML with a file URL. Standalone launchers can open the normal browser. Website login recovery uses a supported external browser whose session the downloader can access within the authorized download flow.

## One service and one selected library

Both the interface and agent use the same running service and selected disk vault. `scripts/vault.py --url <viewer-url> status`, `files` and `jobs` inspect that state; `start`, `cancel` and `reveal` perform requested operations. Do not directly patch a live manifest or start a competing metadata writer.

Require a disk vault before normal operation. Reopen the saved selection; an unavailable folder requires reconnecting or choosing another vault. Never silently replace it with browser-only storage. Opening a native-compatible vault does not authorize conversion, relocation or changes to the native application.

Preserve originals, source IDs, tags, notes, analysis and generated-file ownership. Export through the service, validate the media and register it under its source before showing success. Existing export actions reveal saved files; they do not trigger browser downloads. Library removal and recoverable file deletion are distinct actions described in the operating contracts. Migrations require their own applicable authorization.

## Processing and verification

Run analysis/download jobs only when requested or enabled by the user. Import does not automatically perform shot, subtitle or music recognition. Saved analysis loads immediately; derived covers and waveforms follow the interface workflow. Show real progress, cancellation and actionable failures; preserve distinct unprocessed, failed, cancelled and no-match states.

TransNetV2 and Whisper inference run locally. Download and music identification contact external services. Opening the viewer does not read browser cookies. Never fabricate cuts, transcripts, matches or completion percentages.

For a deployment that includes scene recognition, generate a short local test video yourself with known cuts and run real recognition in a separate, clearly named test library; do not wait for user footage to check basic recognition. Follow the [generated-footage check](references/workflow.md#generated-footage-basic-recognition-check). Never write expected boundaries into the application as if they were model output.

Before handoff, complete the [result-check gate](references/workflow.md#check-results-before-handoff) for the requested features on the running instance the user will receive. Inspect actual playback/seek, visible analysis or exports, correct source ownership and persistence after reopening. A completed job or successful tool probe does not replace inspecting its saved file and browser presentation. Repair failures within the authorized scope and rerun the affected checks; when blocked by missing input, permissions or external access, report the specific blocker and leave that result blocked or unverified. An empty workspace can pass launch checks but cannot pass media-result checks. Keep logs/provenance and distinguish installed, inference-verified and workflow-verified claims.

## Scope and delivery

The package contains instructions, launchers, Python helpers and HTML assets. Tools, models, runtime receipts, cookies, credentials, user media and generated workspaces are separate and must not enter a release ZIP. Back up/move the complete vault when transferring project data.

Configured Apple Silicon execution has been exercised. Windows x64 setup is implemented but still requires real Windows acceptance; Windows ARM64 and other platforms need component-specific investigation. The Windows helper does not install the optional music stack. Native promised-file drag, Apple Music accounts, licensing/updater integration and complete native-app parity are outside this portable implementation. Do not claim platform certification or third-party marketplace approval from package validation alone.
