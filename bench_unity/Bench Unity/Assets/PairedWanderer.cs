#nullable enable

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;

public class PairedWanderer : MonoBehaviour
{
    public PairedWanderer? otherWanderer;

    public Vector3 velocity;
    public Vector2 worldSize;

    public PairedWanderer(Vector3 velocity, Vector2 worldSize, Vector2 position)
    {
        this.velocity = velocity;
        this.worldSize = worldSize;
        transform.position = new Vector3(position.x, position.y, 0);
    }

    void Update()
    {
        // We're not using RigidBody2D here because we don't need it.
        transform.position += velocity * Time.deltaTime;
        if (otherWanderer != null)
        {
            transform.position += otherWanderer.velocity * Time.deltaTime * 0.25f;
        }

        if (transform.position.x < -worldSize.x && velocity.x < 0)
        {
            velocity.x = -velocity.x;
        }
        else if (transform.position.x > worldSize.x && velocity.x > 0)
        {
            velocity.x = -velocity.x;
        }
        if (transform.position.y < -worldSize.y && velocity.y < 0)
        {
            velocity.y = -velocity.y;
        }
        else if (transform.position.y > worldSize.y && velocity.y > 0)
        {
            velocity.y = -velocity.y;
        }

    }
}
