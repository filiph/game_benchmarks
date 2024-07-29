using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class Initialization : MonoBehaviour
{
    public GameObject disappearingButton;
    public GameObject canvas;

    // Start is called before the first frame update
    void Start()
    {
        CreateDisappearingButtons();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void CreateDisappearingButtons()
    {
        for (var i = 0; i < 20; i++)
        {
            var disBtn = Instantiate(disappearingButton, new Vector3(500, 600 - i * 30, 0), Quaternion.identity, canvas.transform);
            var buttonText = disBtn.GetComponentInChildren<TextMeshProUGUI>();
            buttonText.text = $"Button {i + 1}";
        }
    }
}
