﻿using System;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Security;

[assembly: AssemblyTitle("Elysium.Notifications.Server.exe")]
[assembly: AssemblyDescription("Elysium Notifications System Server")]
[assembly: AssemblyProduct("Elysium Notifications System")]
[assembly: AssemblyCopyright("Copyright © Aleksandr Vishnyakov & Codeplex community 2011-2013")]

[assembly: SecurityRules(SecurityRuleSet.Level2)]

[assembly: ComVisible(false)]
[assembly: CLSCompliant(false)]

#if NETFX4
[assembly: AssemblyVersion("2.0.58.0")]
[assembly: AssemblyFileVersion("2.0.58.0")]
#elif NETFX45
[assembly: AssemblyVersion("2.0.71.0")]
[assembly: AssemblyFileVersion("2.0.71.0")]
#endif
[assembly: AssemblyInformationalVersion("2.0 RTM")]