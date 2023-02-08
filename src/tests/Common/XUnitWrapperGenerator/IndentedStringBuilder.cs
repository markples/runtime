// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

namespace XUnitWrapperGenerator;

using System;
using System.Text;

public class IndentedStringBuilder
{
    private readonly StringBuilder _builder = new();
    private int _indentStep;
    private int _currentIndent;
    private bool _atLineStart = true;

    public IndentedStringBuilder(int indentStep = 4) => _indentStep = indentStep;

    public void IncreaseIndent(int numberLevels = 1) => _currentIndent += (numberLevels * _indentStep);
    public void DecreaseIndent(int numberLevels = 1) => IncreaseIndent(-1 * numberLevels);

    public void AppendTo(StringBuilder builder) => builder.Append(_builder);

    private void AppendIndent() => _builder.Append(' ', _currentIndent);

    private void AppendWithinLine(ReadOnlySpan<char> value)
    {
        if (value.Length == 0)
        {
            return;
        }

        if (_atLineStart)
        {
            AppendIndent();
            _atLineStart = false;
        }

        // Why doesn't _builder.Append(value) compile?
        foreach (char c in value)
        {
            _builder.Append(c);
        }
    }

    public IndentedStringBuilder AppendLine()
    {
        _builder.AppendLine();
        _atLineStart = true;
        return this;
    }

    public IndentedStringBuilder Append(string? value)
    {
        if (string.IsNullOrEmpty(value))
        {
            return this;
        }

        int index = 0;
        int newLineIndex;
        while ((newLineIndex = value!.IndexOf(Environment.NewLine, index)) != -1)
        {
            AppendWithinLine(value.AsSpan(index, newLineIndex - index));
            AppendLine();
            index = newLineIndex + Environment.NewLine.Length;
        }
        AppendWithinLine(value.AsSpan(index, value.Length - index));
        return this;
    }

    public IndentedStringBuilder AppendLine(string? value)
    {
        Append(value);
        return AppendLine();
    }
}
