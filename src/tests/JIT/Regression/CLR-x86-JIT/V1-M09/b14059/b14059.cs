// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
//

using System;

namespace b14059
{
public class test
{
    static byte by = 13;
    public static int Main()
    {
        byte by1 = (byte)(-by);

        Console.WriteLine(by1);
        return 100;
    }
}
}
