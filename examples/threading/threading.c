#include "threading.h"
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


// Optional: use these functions to add debug or error prints to your application
#define DEBUG_LOG(msg,...)
//#define DEBUG_LOG(msg,...) printf("threading: " msg "\n" , ##__VA_ARGS__)
#define ERROR_LOG(msg,...) printf("threading ERROR: " msg "\n" , ##__VA_ARGS__)

void* threadfunc(void* thread_param)
{
    struct thread_data* thread_func_args = (struct thread_data *) thread_param;

    usleep(thread_func_args->wait_to_obtain_ms*1000);

    bool success = false;

    int rc = pthread_mutex_lock(thread_func_args->mutex);
    if ( rc != 0 ) 
    {
        printf("pthread_mutex_lock failed with %d\n",rc);
    } 
    else 
    {
        // Critical section
        usleep(thread_func_args->wait_to_release_ms*1000);
        
        success = true;

        rc = pthread_mutex_unlock(thread_func_args->mutex);        
        if ( rc != 0 ) {
            printf("pthread_mutex_unlock failed with %d\n",rc);
            success = false; // not sure if we should give out cash in this case, error on the safe side...
        }
        thread_func_args->thread_complete_success = success;
    }

    return thread_param;
}


bool start_thread_obtaining_mutex(pthread_t *thread, pthread_mutex_t *mutex,int wait_to_obtain_ms, int wait_to_release_ms)
{
    bool success = true;

    struct thread_data* thread_param = (struct thread_data*) malloc(sizeof(struct thread_data));

    memset(thread_param, 0, sizeof(struct thread_data));

    thread_param->mutex = mutex;
    thread_param->wait_to_obtain_ms = wait_to_obtain_ms;
    thread_param->wait_to_release_ms = wait_to_release_ms;

    int rc = pthread_create(thread,
                            NULL, // Use default attributes
                            threadfunc,
                            (void *)thread_param);
    if ( rc != 0 ) {
        printf("pthread_create failed with error %d creating thread\n",rc);
        success = false;
    }

    return success;
}

