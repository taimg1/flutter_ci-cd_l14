#!/bin/bash

# Coverage threshold check script
# This script checks if the test coverage meets the minimum required threshold

set -e

COVERAGE_FILE="coverage/lcov.info"
MIN_COVERAGE=70

# Check if coverage file exists
if [ ! -f "$COVERAGE_FILE" ]; then
  echo "❌ Error: Coverage file not found at $COVERAGE_FILE"
  echo "Please run 'flutter test --coverage' first"
  exit 1
fi

# Function to calculate coverage percentage
calculate_coverage() {
  # Use lcov to get coverage summary
  local summary=$(lcov --summary "$COVERAGE_FILE" 2>&1)
  
  # Extract lines coverage percentage
  local coverage=$(echo "$summary" | grep "lines" | grep -oP '\d+\.\d+(?=%)')
  
  # If grep didn't find anything, try alternative format
  if [ -z "$coverage" ]; then
    coverage=$(echo "$summary" | grep "lines" | awk '{print $2}' | cut -d'%' -f1)
  fi
  
  echo "$coverage"
}

echo "📊 Checking test coverage..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Calculate current coverage
CURRENT_COVERAGE=$(calculate_coverage)

if [ -z "$CURRENT_COVERAGE" ]; then
  echo "❌ Error: Could not calculate coverage"
  exit 1
fi

# Round to integer for comparison
CURRENT_INT=$(printf "%.0f" "$CURRENT_COVERAGE")

echo "📈 Current coverage: ${CURRENT_COVERAGE}%"
echo "🎯 Minimum required: ${MIN_COVERAGE}%"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Compare with threshold
if [ "$CURRENT_INT" -lt "$MIN_COVERAGE" ]; then
  echo "❌ FAILED: Coverage ${CURRENT_COVERAGE}% is below minimum ${MIN_COVERAGE}%"
  echo ""
  echo "💡 Tips to improve coverage:"
  echo "   - Add more unit tests for uncovered code"
  echo "   - Test edge cases and error handling"
  echo "   - Run 'flutter test --coverage' to generate detailed report"
  echo "   - Check coverage/html/index.html for detailed breakdown"
  echo ""
  exit 1
else
  DIFF=$(echo "$CURRENT_COVERAGE - $MIN_COVERAGE" | bc)
  echo "✅ SUCCESS: Coverage check passed!"
  echo "🎉 You exceeded the minimum by ${DIFF}%"
  echo ""
fi

# Generate detailed coverage report
echo "📋 Detailed coverage report:"
lcov --list "$COVERAGE_FILE" | head -n 20

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✨ Coverage check completed successfully!"

exit 0
