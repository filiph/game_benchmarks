using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MusicPlay : MonoBehaviour
{
    public AudioSource music;

    // Start is called before the first frame update
    void Start()
    {
        music.Play();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void toggleAudioOn()
    {
        if (music.isPlaying)
        {
            music.Pause();
        } else
        {
            music.UnPause();
        }
    }
}
