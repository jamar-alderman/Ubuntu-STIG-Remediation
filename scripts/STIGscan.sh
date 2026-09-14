#!/bin/bash

PROFILE="xccdf_org.ssgproject.content_profile_stig"
DATASTREAM="/usr/share/xml/scap/ssg/content/ssg-rl10-ds.xml"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

echo "======================================"
echo "Starting RHEL 10 OpenSCAP STIG-aligned scan..."
echo "======================================"

sudo oscap xccdf eval \
  --profile "$PROFILE" \
  --results "$HOME/results-$DATE.xml" \
  --report "$HOME/report-$DATE.html" \
  "$DATASTREAM"
SCAN_STATUS=$?

# OpenSCAP returns 2 for an evaluation with fail or unknown rule results.
if [[ "$SCAN_STATUS" -ne 0 && "$SCAN_STATUS" -ne 2 ]]; then
  echo "OpenSCAP evaluation error (exit $SCAN_STATUS); not starting the web server." >&2
  exit "$SCAN_STATUS"
fi

if [[ ! -s "$HOME/results-$DATE.xml" || ! -s "$HOME/report-$DATE.html" ]]; then
  echo "Expected scan files are missing or empty; not starting the web server." >&2
  exit 1
fi

echo
echo "======================================"
echo "Evaluation finished (OpenSCAP exit $SCAN_STATUS)"
echo "Report : $HOME/report-$DATE.html"
echo "Results: $HOME/results-$DATE.xml"
echo "======================================"
echo
echo "Starting temporary web server on port 8000..."
echo "WARNING: This serves your entire home directory to reachable clients."
echo "Use only on an isolated trusted lab network. Stop with Ctrl+C."

cd "$HOME" || exit 1

IP=$(hostname -I | awk '{print $1}')

echo
echo "Open your report at:"
echo "http://$IP:8000/report-$DATE.html"

python3 -m http.server 8000
