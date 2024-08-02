using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LogoSwing : MonoBehaviour
{

    void Update()
    {
        var age = Time.time;

        transform.eulerAngles = new Vector3(0, 0, Mathf.Sin(age / 2) * 0.05f / Mathf.PI * 180); 
    }
}
