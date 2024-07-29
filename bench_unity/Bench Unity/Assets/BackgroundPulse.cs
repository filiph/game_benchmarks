using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class BackgroundPulse : MonoBehaviour
{
    Vector3 minScale;

    // Start is called before the first frame update
    void Start()
    {
        minScale = transform.localScale;
    }

    // Update is called once per frame
    void Update()
    {
        var age = Time.time;

        transform.localScale = minScale * (1 + (float) Math.Sin(age / 6.0) * 0.05f);
    }
}
