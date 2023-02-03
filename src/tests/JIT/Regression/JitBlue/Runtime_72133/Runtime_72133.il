// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

.assembly extern System.Runtime { .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A ) }
.assembly extern System.Console { }
.assembly extern System.Numerics.Vectors { }

.assembly Runtime_72133 { }

#define TRUE "1"
#define FALSE "0"

.typedef [System.Numerics.Vectors]System.Numerics.Vector2 as Vector2

.namespace Runtime_72133
{
.class public Runtime_72133 extends [System.Runtime]System.Object
{
  .method public static int32 Main()
  {
    .entrypoint
    .locals (int32 result)

    ldc.i4 100
    stloc result

    call bool .this::ProblemWithStructStObj()
    brfalse VECTOR_STOBJ

    ldloca result
    ldstr "STRUCT_STOBJ failed"
    call void .this::ReportFailure(int32*, string)

  VECTOR_STOBJ:
    call bool .this::ProblemWithVectorStObj()
    brfalse CPBLK

    ldloca result
    ldstr "VECTOR_STOBJ failed"
    call void .this::ReportFailure(int32*, string)

  CPBLK:
    call bool .this::ProblemWithCpBlk()
    brfalse INITBLK

    ldloca result
    ldstr "CPBLK failed"
    call void .this::ReportFailure(int32*, string)

  INITBLK:
    call bool .this::ProblemWithInitBlk()
    brfalse INITOBJ

    ldloca result
    ldstr "INITBLK failed"
    call void .this::ReportFailure(int32*, string)

  INITOBJ:
    call bool .this::ProblemWithInitObj()
    brfalse DIRECT_INITOBJ

    ldloca result
    ldstr "INITOBJ failed"
    call void .this::ReportFailure(int32*, string)

  DIRECT_INITOBJ:
    call bool .this::ProblemWithDirectInitObj()
    brfalse RET_BUF_CALL

    ldloca result
    ldstr "DIRECT_INITOBJ failed"
    call void .this::ReportFailure(int32*, string)

  RET_BUF_CALL:
    call bool .this::ProblemWithRetBufCall()
    brfalse RETURN

    ldloca result
    ldstr "RET_BUF_CALL failed"
    call void .this::ReportFailure(int32*, string)

  RETURN:
    ldloc result
    ret
  }

  .method private static bool ProblemWithStructStObj() noinlining
  {
    .locals (int32 a, int32 b, int32 offs)

    ldc.i4 1
    call !!0 .this::Get<int32>(!!0)
    stloc a

    ldc.i4 2
    call !!0 .this::Get<int32>(!!0)
    stloc b

    ldc.i4 0
    call !!0 .this::Get<int32>(!!0)
    stloc offs

    ldloc a

    ldloca a
    ldloc offs
    add
    ldloca b
    ldobj Runtime_72133.StructWithInt
    stobj Runtime_72133.StructWithInt

    ldc.i4 1
    bne.un FAILURE
    ldc.i4 FALSE
    ret

  FAILURE:
    ldc.i4 TRUE
    ret
  }

  .method private static bool ProblemWithVectorStObj() noinlining
  {
    .locals (int64 a, int64 b, int32 offs)

    ldc.i8 1
    call !!0 .this::Get<int64>(!!0)
    stloc a

    ldc.i8 2
    call !!0 .this::Get<int64>(!!0)
    stloc b

    ldc.i4 0
    call !!0 .this::Get<int32>(!!0)
    stloc offs

    ldloc a

    ldloca a
    ldloc offs
    add
    ldloca b
    ldobj Vector2
    stobj Vector2

    ldc.i8 1
    bne.un FAILURE
    ldc.i4 FALSE
    ret

  FAILURE:
    ldc.i4 TRUE
    ret
  }

  .method private static bool ProblemWithCpBlk() noinlining
  {
    .locals (int32 a, int32 b, int32 offs)

    ldc.i4 1
    call !!0 .this::Get<int32>(!!0)
    stloc a

    ldc.i4 2
    call !!0 .this::Get<int32>(!!0)
    stloc b

    ldc.i4 0
    call !!0 .this::Get<int32>(!!0)
    stloc offs

    ldloc a

    ldloca a
    ldloc offs
    add
    ldloca b
    sizeof int32
    cpblk

    ldc.i4 1
    bne.un FAILURE
    ldc.i4 FALSE
    ret

  FAILURE:
    ldc.i4 TRUE
    ret
  }

  .method private static bool ProblemWithInitBlk() noinlining
  {
    .locals (int32 a, int32 b, int32 offs)

    ldc.i4 1
    call !!0 .this::Get<int32>(!!0)
    stloc a

    ldc.i4 2
    call !!0 .this::Get<int32>(!!0)
    stloc b

    ldc.i4 0
    call !!0 .this::Get<int32>(!!0)
    stloc offs

    ldloc a

    ldloca a
    ldloc offs
    add
    ldloc b
    sizeof int32
    initblk

    ldc.i4 1
    bne.un FAILURE
    ldc.i4 FALSE
    ret

  FAILURE:
    ldc.i4 TRUE
    ret
  }

  .method private static bool ProblemWithInitObj() noinlining
  {
    .locals (object a, int32 offs)

    newobj instance void object::.ctor()
    call !!0 .this::Get<object>(!!0)
    stloc a

    ldc.i4 0
    call !!0 .this::Get<int32>(!!0)
    stloc offs

    ldloc a

    ldloca a
    ldloc offs
    add
    initobj object

    ldnull
    beq FAILURE
    ldc.i4 FALSE
    ret

  FAILURE:
    ldc.i4 TRUE
    ret
  }

  .method private static bool ProblemWithDirectInitObj() noinlining
  {
    .locals (valuetype Runtime_72133.StructWithInt a, valuetype Runtime_72133.StructWithInt* pA)

    ldloca a
    ldflda int32 Runtime_72133.StructWithInt::Value
    ldc.i4 1
    call !!0 .this::Get<int32>(!!0)
    stfld int32 Runtime_72133.StructWithInt::Value

    ldloca a
    stloc pA

    ldloc pA
    ldfld int32 Runtime_72133.StructWithInt::Value

    ldloca a
    initobj Runtime_72133.StructWithInt

    ldc.i4 1
    bne.un FAILURE
    ldc.i4 FALSE
    ret

  FAILURE:
    ldc.i4 TRUE
    ret
  }

  .method private static bool ProblemWithRetBufCall() noinlining
  {
    .locals (valuetype Runtime_72133.LargeStruct a, valuetype Runtime_72133.LargeStruct b)

    ldc.i8 1
    call valuetype Runtime_72133.LargeStruct Runtime_72133.LargeStruct::CreateNoinline(int64)
    dup
    stloc a
    stloc b

    ldloc a

    ldc.i8 2
    call valuetype Runtime_72133.LargeStruct Runtime_72133.LargeStruct::CreateInline(int64)
    stloc a

    ldloc b
    call bool Runtime_72133.LargeStruct::Equals(valuetype Runtime_72133.LargeStruct, valuetype Runtime_72133.LargeStruct)
    brfalse FAILURE

    ldloc b
    stloc a

    ldloc a

    ldc.i8 3
    call valuetype Runtime_72133.LargeStruct Runtime_72133.LargeStruct::CreateInline(int64)
    stloc a

    ldloc b
    call bool Runtime_72133.LargeStruct::Equals(valuetype Runtime_72133.LargeStruct, valuetype Runtime_72133.LargeStruct)
    brfalse FAILURE

    ldc.i4 FALSE
    ret

  FAILURE:
    ldc.i4 TRUE
    ret
  }

  .method private static !!T Get<T>(!!T arg) noinlining
  {
    ldarg arg
    ret
  }

  .method private static void ReportFailure(int32* pResult, string msg) noinlining
  {
    ldarg pResult
    ldarg pResult
    ldind.i4
    ldc.i4 1
    add
    stind.i4

    ldarg msg
    call void [System.Console]System.Console::WriteLine(string)

    ret
  }
}

.class sealed sequential StructWithInt extends [System.Runtime]System.ValueType
{
  .field public int32 Value
}

.class sealed sequential LargeStruct extends [System.Runtime]System.ValueType
{
  .field public int64 LongOne
  .field public int64 LongTwo
  .field public int64 LongThree

  .method public static bool Equals(valuetype Runtime_72133.LargeStruct left, valuetype Runtime_72133.LargeStruct right) noinlining
  {
    ldarg left
    ldfld int64 .this::LongOne
    ldarg right
    ldfld int64 .this::LongOne
    bne.un NOT_EQUAL

    ldarg left
    ldfld int64 .this::LongTwo
    ldarg right
    ldfld int64 .this::LongTwo
    bne.un NOT_EQUAL

    ldarg left
    ldfld int64 .this::LongThree
    ldarg right
    ldfld int64 .this::LongThree
    bne.un NOT_EQUAL

    ldc.i4 TRUE
    ret

  NOT_EQUAL:
    ldc.i4 FALSE
    ret
  }

  .method public static valuetype Runtime_72133.LargeStruct CreateInline(int64 fieldValue)
  {
    .locals (valuetype Runtime_72133.LargeStruct result)

    ldloca result
    ldarg fieldValue
    stfld int64 .this::LongOne

    ldloca result
    ldarg fieldValue
    stfld int64 .this::LongTwo

    ldloca result
    ldarg fieldValue
    stfld int64 .this::LongThree

    ldloc result
    ret
  }

  .method public static valuetype Runtime_72133.LargeStruct CreateNoinline(int64 fieldValue) noinlining
  {
    ldarg fieldValue
    call valuetype Runtime_72133.LargeStruct .this::CreateInline(int64)
    ret
  }
}
}
