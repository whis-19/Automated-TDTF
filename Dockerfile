FROM appium/appium:latest

# Switch to root to install SDKs without permission issues
USER root

# Install Android SDK components
RUN yes | sdkmanager "platform-tools" "platforms;android-29" "system-images;android-29;default;x86_64" "emulator"

# Create AVD
RUN echo "no" | avdmanager create avd -n test_avd -k "system-images;android-29;default;x86_64" --device "Nexus 6"

# Fix permissions
RUN chown -R androidusr:androidusr /opt/android /home/androidusr/.android || true

# Drop privileges back to appium user
USER androidusr

# Expose Appium port
EXPOSE 4723

# Start Appium server
CMD ["appium", "--address", "0.0.0.0", "--port", "4723", "--allow-insecure", "adb_shell"]
