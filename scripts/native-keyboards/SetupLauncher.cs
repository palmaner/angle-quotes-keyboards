using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Security.Principal;
using System.Text;
using System.Windows.Forms;

// Only msiexec is elevated. The preference UI always runs as the initiating user.
internal static class SetupLauncher {
    static string Caption { get { return "Angle Quotes - v" + Application.ProductVersion; } }
    [STAThread]
    static int Main() {
        string temp = null;
        try {
            if (new WindowsPrincipal(WindowsIdentity.GetCurrent()).IsInRole(WindowsBuiltInRole.Administrator)) {
                MessageBox.Show("Abre setup.exe normalmente, sin «Ejecutar como administrador».\nOpen setup.exe normally, without 'Run as administrator'.", Caption);
                return 1;
            }
            string arch = Environment.GetEnvironmentVariable("PROCESSOR_ARCHITEW6432") ?? Environment.GetEnvironmentVariable("PROCESSOR_ARCHITECTURE");
            if (String.Equals(arch, "ARM64", StringComparison.OrdinalIgnoreCase))
                throw new NotSupportedException("ARM64 is not supported.");
            temp = Path.Combine(Path.GetTempPath(), "AngleQuotes-" + Guid.NewGuid().ToString("N"));
            Directory.CreateDirectory(temp);
            foreach (string name in new [] {"setup-ui.ps1", "setup-core.ps1", "setup-msi.ps1", "setup-config.json"}) {
                using (Stream source = Assembly.GetExecutingAssembly().GetManifestResourceStream(name))
                using (Stream target = File.Create(Path.Combine(temp, name))) { source.CopyTo(target); }
            }
            string shell = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Windows), "System32", "WindowsPowerShell", "v1.0", "powershell.exe");
            // Use Sysnative if a 32-bit caller starts this AnyCPU executable on x64.
            if (Environment.Is64BitOperatingSystem && !Environment.Is64BitProcess)
                shell = shell.Replace("System32", "Sysnative");
            string root = AppDomain.CurrentDomain.BaseDirectory.TrimEnd(Path.DirectorySeparatorChar);
            var start = new ProcessStartInfo(shell, "-NoProfile -STA -ExecutionPolicy Bypass -WindowStyle Hidden -File \"" + Path.Combine(temp, "setup-ui.ps1") + "\" -PackageRoot \"" + root + "\"");
            start.UseShellExecute = false;
            start.CreateNoWindow = true;
            using (Process process = Process.Start(start)) { process.WaitForExit(); return process.ExitCode; }
        } catch (Exception error) {
            MessageBox.Show(error.Message, Caption, MessageBoxButtons.OK, MessageBoxIcon.Error);
            return 1;
        } finally {
            try { if (temp != null && Directory.Exists(temp)) Directory.Delete(temp, true); }
            catch (IOException) { /* A busy temporary file must not turn success into failure. */ }
            catch (UnauthorizedAccessException) { }
        }
    }
}
