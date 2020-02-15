using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour
{
    public Vector3 r;

    void Start()
    {

    }

    void Update()
    {
        transform.Rotate(r);
    }
}
