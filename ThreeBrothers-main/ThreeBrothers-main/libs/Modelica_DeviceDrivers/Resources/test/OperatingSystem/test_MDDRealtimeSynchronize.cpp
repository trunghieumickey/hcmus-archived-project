#include <stdio.h>
#include "../../Include/MDDRealtimeSynchronize.h"

#include "gtest/gtest.h"

namespace {
TEST(MDDRealtimeSynchronize, realtime) {

    double simTime, availableTime, calculationTime;
    double Ts = 0.1;
    int alwaysInTime = 1;
    void* procPrio = MDD_ProcessPriorityConstructor();
    void* rtSync = MDD_realtimeSynchronizeConstructor();

    printf("Priority \"Realtime\" with Ts=%lf...\n", Ts);
    MDD_setPriority(procPrio, 2);
    for (simTime=Ts; simTime < 1.0; simTime += Ts) {
      calculationTime = MDD_realtimeSynchronize(rtSync, simTime, 0, 1, &availableTime);
      printf("simTime: %lf, availableTime: %lf, calculationTime: %lf\n", simTime, availableTime, calculationTime);
      alwaysInTime = alwaysInTime && availableTime > 0;
    }
    printf("Priority \"Realtime\", alwaysInTime: %s\n", alwaysInTime ? "true" : "false");
    MDD_realtimeSynchronizeDestructor(rtSync);
    MDD_ProcessPriorityDestructor(procPrio);
    EXPECT_GT(alwaysInTime, 0);
}

TEST(MDDRealtimeSynchronize, high) {

    double simTime, availableTime, calculationTime;
    double Ts = 0.1;
    int alwaysInTime = 1;
    void* procPrio = MDD_ProcessPriorityConstructor();
    void* rtSync = MDD_realtimeSynchronizeConstructor();

    printf("Priority \"high\" with Ts=%lf...\n", Ts);
    MDD_setPriority(procPrio, 1);
    for (simTime = Ts; simTime < 1.0; simTime += Ts) {
        calculationTime = MDD_realtimeSynchronize(rtSync, simTime, 0, 1, &availableTime);
        printf("simTime: %lf, availableTime: %lf, calculationTime: %lf\n", simTime, availableTime, calculationTime);
        alwaysInTime = alwaysInTime && availableTime > 0;
    }
    printf("Priority \"high\", alwaysInTime: %s\n", alwaysInTime ? "true" : "false");
    MDD_realtimeSynchronizeDestructor(rtSync);
    MDD_ProcessPriorityDestructor(procPrio);
    EXPECT_GT(alwaysInTime, 0);
}

TEST(MDDRealtimeSynchronize, normal) {

    double simTime, availableTime, calculationTime;
    double Ts = 0.1;
    int alwaysInTime = 1;
    void* procPrio = MDD_ProcessPriorityConstructor();
    void* rtSync = MDD_realtimeSynchronizeConstructor();

    printf("Priority \"Normal\" with Ts=%lf...\n", Ts);
    MDD_setPriority(procPrio, 0);
    for (simTime = Ts; simTime < 1.0; simTime += Ts) {
        calculationTime = MDD_realtimeSynchronize(rtSync, simTime, 0, 1, &availableTime);
        printf("simTime: %lf, availableTime: %lf, calculationTime: %lf\n", simTime, availableTime, calculationTime);
        alwaysInTime = alwaysInTime && availableTime > 0;
    }
    printf("Priority \"Normal\", alwaysInTime: %s\n", alwaysInTime ? "true" : "false");
    MDD_realtimeSynchronizeDestructor(rtSync);
    MDD_ProcessPriorityDestructor(procPrio);
    EXPECT_GT(alwaysInTime, 0);
}

TEST(MDDRealtimeSynchronize, low) {
    double simTime, availableTime, calculationTime;
    double Ts = 0.1;
    int alwaysInTime = 1;
    void* procPrio = MDD_ProcessPriorityConstructor();
    void* rtSync = MDD_realtimeSynchronizeConstructor();

    printf("Priority \"below normal\" with Ts=%lf...\n", Ts);
    MDD_setPriority(procPrio, -1);
    for (simTime = Ts; simTime < 1.0; simTime += Ts) {
        calculationTime = MDD_realtimeSynchronize(rtSync, simTime, 0, 1, &availableTime);
        printf("simTime: %lf, availableTime: %lf, calculationTime: %lf\n", simTime, availableTime, calculationTime);
        alwaysInTime = alwaysInTime && availableTime > 0;
    }
    printf("Priority \"below normal\", alwaysInTime: %s\n", alwaysInTime ? "true" : "false");
    MDD_realtimeSynchronizeDestructor(rtSync);
    MDD_ProcessPriorityDestructor(procPrio);
    EXPECT_GT(alwaysInTime, 0);
}

TEST(MDDRealtimeSynchronize, idle) {
    double simTime, availableTime, calculationTime;
    double Ts = 0.1;
    int alwaysInTime = 1;
    void* procPrio = MDD_ProcessPriorityConstructor();
    void* rtSync = MDD_realtimeSynchronizeConstructor();

    printf("Priority \"Idle\" with Ts=%lf...\n", Ts);
    MDD_setPriority(procPrio, -2);
    for (simTime = Ts; simTime < 1.0; simTime += Ts) {
        calculationTime = MDD_realtimeSynchronize(rtSync, simTime, 0, 1, &availableTime);
        printf("simTime: %lf, availableTime: %lf, calculationTime: %lf\n", simTime, availableTime, calculationTime);
        alwaysInTime = alwaysInTime && availableTime > 0;
    }
    printf("Priority \"Idle\", alwaysInTime: %s\n", alwaysInTime ? "true" : "false");
    MDD_realtimeSynchronizeDestructor(rtSync);
    MDD_ProcessPriorityDestructor(procPrio);
    EXPECT_GT(alwaysInTime, 0);
}

}
