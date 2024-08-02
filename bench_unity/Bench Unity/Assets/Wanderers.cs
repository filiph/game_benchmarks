using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Wanderers : MonoBehaviour
{
    public const int batchSize = 100;

    public PairedWanderer prefab;

    public Vector2 worldSize;

    List<PairedWanderer> wanderers = new List<PairedWanderer>();

    public void AddBatch()
    {
        for (var i = 0; i < batchSize / 2; i++)
        {
            var a = Instantiate(prefab);
            a.velocity = new Vector2(Random.Range(-0.5f, 0.5f) * 5, Random.Range(-0.5f, 0.5f) * 5);
            a.worldSize = worldSize;
            a.transform.position = new Vector3(worldSize.x * Random.Range(-1f, 1f),
                                               worldSize.y * Random.Range(-1f, 1f));
            var b = Instantiate(prefab);
            b.velocity = new Vector2(Random.Range(-0.5f, 0.5f) * 5, Random.Range(-0.5f, 0.5f) * 5);
            b.worldSize = worldSize;
            b.transform.position = new Vector3(worldSize.x * Random.Range(-1f, 1f),
                                               worldSize.y * Random.Range(-1f, 1f));
            a.otherWanderer = b;
            b.otherWanderer = a;
            wanderers.Add(a);
            wanderers.Add(b);
        }
    }

    public void RemoveBatch()
    {
        if (wanderers.Count == 0)
        {
            Debug.Log("Cannot remove from empty list.");
            return;
        }

        for (var i = wanderers.Count - batchSize; i < wanderers.Count; i++)
        {
            Destroy(wanderers[i].gameObject);
        }
        wanderers.RemoveRange(wanderers.Count - batchSize, batchSize);
    }
}
