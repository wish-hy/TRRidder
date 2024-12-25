//
// Created by qiuwenchen on 2022/7/13.
//

/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#pragma once

#include "WinqBridge.h"

WCDB_EXTERN_C_BEGIN

CPPStatementDropTrigger WCDBStatementDropTriggerCreate(void);
void WCDBStatementDropTriggerConfigSchema(CPPStatementDropTrigger dropTriggerStatement,
                                          CPPSchema schema);
void WCDBStatementDropTriggerConfigSchema2(CPPStatementDropTrigger dropTriggerStatement,
                                           CPPCommonValue schema);
void WCDBStatementDropTriggerConfigTrigger(CPPStatementDropTrigger dropTriggerStatement,
                                           const char* _Nullable name);
void WCDBStatementDropTriggerConfigIfExists(CPPStatementDropTrigger dropTriggerStatement);

WCDB_EXTERN_C_END
