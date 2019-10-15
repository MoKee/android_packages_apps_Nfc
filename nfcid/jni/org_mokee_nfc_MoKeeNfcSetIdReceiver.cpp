/*
 * Copyright (C) 2019 The MoKee Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <unistd.h>
#include <pthread.h>
#include <nfa_dm_int.h>

#include "org_mokee_nfc.h"

extern "C" {

JNIEXPORT jint JNICALL Java_org_mokee_nfc_MoKeeNfcSetIdReceiver_setId(
        JNIEnv *env, jobject This, jbyteArray uid)
{
    int ret = 0;
    tNFA_DM_MSG data;

    jbyte *buf = env->GetByteArrayElements(uid, NULL);
    size_t buf_len = (size_t) env->GetArrayLength(uid);

    if (buf_len != 4) {
        ret = -1;
        goto end;
    }

    data.setconfig = tNFA_DM_API_SET_CONFIG {
        {},
        NFC_PMID_LA_NFCID1,
        (uint8_t) buf_len,
        (uint8_t *) buf
    };

    if (NFC_Deactivate(NFC_DEACTIVATE_TYPE_IDLE) != NFC_STATUS_OK) {
        ret = -2;
        goto end;
    }

    if (!nfa_dm_set_config(&data)) {
        ret = -3;
        goto end;
    }

    if (NFC_Deactivate(NFC_DEACTIVATE_TYPE_DISCOVERY) != NFC_STATUS_OK) {
        ret = -4;
        goto end;
    }

end:
    env->ReleaseByteArrayElements(uid, buf, 0);
    return ret;
}

}
