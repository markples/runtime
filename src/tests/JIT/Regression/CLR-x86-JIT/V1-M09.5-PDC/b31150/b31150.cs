// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using Xunit;
namespace b31150
{
public class foo
{
    [Fact]
    public static int TestEntryPoint()
    {
        long lo = 0x01;
        lo = lo << 63;
        System.Console.WriteLine(lo >> 32);
        System.Console.WriteLine(lo >> 33);
        return 100;
    }
}
}
